//
//  CustomProduct.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/19/23.
//

import Foundation

struct CustomProduct: Identifiable, Codable  {
    let id = UUID()
    let product: Product
    let customizationOptions: [any ProductCustomizationOptionProtocol]
    let sizeOption: ProductSizeOption?
    
    var modifiedOptions: [any ProductCustomizationOptionProtocol] {
        var returnList: [any ProductCustomizationOptionProtocol] = []
        for option in customizationOptions {
            if option.isModified {
                returnList.append(option)
            }
        }
        return returnList
    }
    

    
    enum CodingKeys: String, CodingKey {
        case product
        
        case customizationOptions
        case sizeOption
    }
    
    init(product: Product, customizationOptions: [any ProductCustomizationOptionProtocol], sizeOption: ProductSizeOption?) {
        self.product = product
        self.customizationOptions = customizationOptions
        self.sizeOption = sizeOption
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode the product
        product = try values.decode(Product.self, forKey: .product)
        
        // Decode the array of customization options
        var customizationOptionsContainer = try values.nestedUnkeyedContainer(forKey: .customizationOptions)
        var decodedArray: [any ProductCustomizationOptionProtocol] = []
        
        while !customizationOptionsContainer.isAtEnd {
            if let element = try? customizationOptionsContainer.decode(ProductCustomizationStepper.self) {
                decodedArray.append(element)
            } else if let element = try? customizationOptionsContainer.decode(ProductCustomizationDropdown.self) {
                decodedArray.append(element)
            } else {
                // Handle other cases or throw an error as needed
                fatalError("Unable to decode element")
            }
        }
        
        customizationOptions = decodedArray
        
        // Decode the size option
        sizeOption = try values.decode(ProductSizeOption.self, forKey: .sizeOption)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(product, forKey: .product)
        
        var customizationOptionsContainer = container.nestedUnkeyedContainer(forKey: .customizationOptions)
        for element in customizationOptions {
            try customizationOptionsContainer.encode(element)
        }
        
        try container.encode(sizeOption, forKey: .sizeOption)
        
    }
    
    func changing<T>(path: WritableKeyPath<CustomProduct, T>, to value: T) -> CustomProduct {
        var clone = self
        clone[keyPath: path] = value
        return clone
    }
    
    static var example: CustomProduct {
        CustomProduct(product: Product.example, customizationOptions: [], sizeOption: .venti)
    }
    
    func isEqual(product2: CustomProduct) -> Bool {
        if product2.product != product {return false}
        if sizeOption != product2.sizeOption {return false}
        guard customizationOptions.count == product2.customizationOptions.count else {return false}
        for (index, option) in customizationOptions.enumerated() {
            if product2.customizationOptions[index].label != option.label {
                return false
            }
        }
        return true
    }
}

protocol ProductCustomizationOptionProtocol: Identifiable, Codable {
    var id: UUID {get}
    var isDropdown: Bool {get}
    var isModified: Bool {get}
    var label: String {get}
    
    func reset() -> any ProductCustomizationOptionProtocol;
    
    init(optionStruct: ProductCustomizationOption);
}

struct ProductCustomizationDropdown: ProductCustomizationOptionProtocol, Codable {
    func reset() -> any ProductCustomizationOptionProtocol {
        return changing(path: \.selectedOption, to: defaultOption)
    }
    
    func changing<T>(path: WritableKeyPath<ProductCustomizationDropdown, T>, to value: T) -> ProductCustomizationDropdown {
        var clone = self
        clone[keyPath: path] = value
        return clone
    }
    
    var id = UUID()
    
    var isDropdown = false
    var label: String
    
    var selectedOption: String
    let defaultOption: String
    var options: [String] = []
    
    init(optionStruct: ProductCustomizationOption) {
        defaultOption = optionStruct.defaultValueDropdown ?? optionStruct.options?[0] ?? ""
        selectedOption = defaultOption
        options = optionStruct.options ?? [""]
        self.isDropdown = true
        label = defaultOption
    }
    
    var isModified: Bool {
        defaultOption != selectedOption
    }

}

struct ProductCustomizationStepper: ProductCustomizationOptionProtocol {
    func changing<T>(path: WritableKeyPath<ProductCustomizationStepper, T>, to value: T) -> ProductCustomizationStepper {
        var clone = self
        clone[keyPath: path] = value
        return clone
    }
    
    var id = UUID()
    
    var isDropdown: Bool
    
    var value = 3
    let label: String
    
    let defaultValue: Int
    init(optionStruct: ProductCustomizationOption) {
        defaultValue = Int(optionStruct.defaultValueStepper ?? "0") ?? 0
        value = defaultValue
        self.isDropdown = false
        label = "Placeholder"
    }
    
    var isModified: Bool {
        value != defaultValue
    }
    
    func reset() -> any ProductCustomizationOptionProtocol{
        return changing(path: \.value, to: defaultValue)
    }
    
    
    func decrement() -> ProductCustomizationStepper {
        return changing(path: \.value, to: value - 1)
        
    }
    
    func increment() -> ProductCustomizationStepper{
        return changing(path: \.value, to: value + 1)
    }
}
