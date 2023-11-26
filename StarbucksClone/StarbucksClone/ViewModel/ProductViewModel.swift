//
//  ProductViewModel.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/18/23.
//

import Foundation


class ProductViewModel: ObservableObject {
    let product: Product
    
    @Published var customizationOptions: [any ProductCustomizationOptionProtocol] = []
    @Published var selectedSize: ProductSizeOption? = .grande
    
    var isFavorited: Bool {
        let customProduct = CustomProduct(product: product,  customizationOptions: customizationOptions, sizeOption: selectedSize)
        return FavoriteService.shared.isFavorite(product: customProduct)
    }
    
    func toggleFavorite() {
        let customProduct = CustomProduct(product: product,  customizationOptions: customizationOptions, sizeOption: selectedSize)
        FavoriteService.shared.toggleFavorite(product: customProduct)
    }
    
    let availableSizes: [ProductSizeOption]?
    
    init(product: Product) {
        print("initalizing the product view model...")
        self.product = product
        
        availableSizes = product.productSizeOptions
        if product.productSizeOptions == [] {
            selectedSize = nil
        }
        
        for productCustomizationOption in product.productCustomizationOptions {
            if productCustomizationOption.isDropdown {
                customizationOptions.append(ProductCustomizationDropdown(optionStruct: productCustomizationOption))
            } else {
                customizationOptions.append(ProductCustomizationStepper(optionStruct: productCustomizationOption))
            }
        }
    }
    
    func resetCustomizations() {
        print("resetting customizations...")
        var newCustomizations: [any ProductCustomizationOptionProtocol] = []
        for option in customizationOptions {
            newCustomizations.append(option.reset())
        }
        customizationOptions = newCustomizations
    }
    
    var areSizes: Bool {
        guard availableSizes != nil else {
            return false
        }
        let noSizeCategories: [ProductBigCategory] = [.food, .atHomeCoffee, .merchandise]
        if noSizeCategories.contains(product.productBigCategory) {return false}
        
        return true
    }
    
    var areOptions: Bool {
        !customizationOptions.isEmpty
    }
    
    var isModified: Bool {
        for option in customizationOptions {
            if option.isModified {
                return true
            }
        }
        return false
    }
    
    func getImageNameFromSize(size: ProductSizeOption) -> String {
        if (size == selectedSize) {
            return  product.imageType.rawValue + baseImage(size: size) + "fill"
        } else {
            return product.imageType.rawValue + baseImage(size: size) + "nofill"
        }
        
        func baseImage(size: ProductSizeOption) -> String {
            switch size {
            case .grande: return "grande";
            case .short: return "short";
            case .tall: return "tall";
            case .trenta: return "trenta";
            case .venti: return "venti"
            }
        }
    }
    
    func changeDropdownOption(option: ProductCustomizationDropdown, selection: String) {
        // finding the option
        for (index, option_) in customizationOptions.enumerated() {
            if option_.id == option.id {
                customizationOptions[index] = option.changing(path: \.selectedOption, to: selection)
            }
        }
    }
    
    func incrementStepper(option: ProductCustomizationStepper) {
        // finding the option
        for (index, option_) in customizationOptions.enumerated() {
            if option_.id == option.id {
                let option2: ProductCustomizationStepper = option_ as! ProductCustomizationStepper
                customizationOptions[index] = option2.increment()
            }
        }
    }
    
    func decrementStepper(option: ProductCustomizationStepper) {
        // finding the option
        for (index, option_) in customizationOptions.enumerated() {
            if option_.id == option.id {
                let option2: ProductCustomizationStepper = option_ as! ProductCustomizationStepper
                customizationOptions[index] = option2.decrement()
            }
        }
    }
    
    func addToOrder() {
        let customProduct = CustomProduct(product: product, customizationOptions: customizationOptions, sizeOption: selectedSize)
        CartService.shared.addProductToOrder(product: customProduct)
    }
    
    
}
