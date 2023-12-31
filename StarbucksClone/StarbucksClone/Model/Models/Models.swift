// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation



// MARK: - WelcomeElement
struct Product: Codable, Identifiable, Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.productName == rhs.productName
    }
    
    var id = UUID()
    let productName: String
    let productCalories, productStars: String?
    let productImagePath: String
    let productNutritionSummary: String?
    let productSizeOptions: [ProductSizeOption]?
    let productDescription: String?
    let productCategory: ProductCategory
    let productSubCategory: String?
    let productBigCategory: ProductBigCategory
    let productCustomizationOptions: [ProductCustomizationOption]

    enum CodingKeys: String, CodingKey {
        case productName = "product_name"
        case productCalories = "product_calories"
        case productStars = "product_stars"
        case productImagePath = "product_image_path"
        case productNutritionSummary = "product_nutrition_summary"
        case productSizeOptions = "product_size_options"
        case productDescription = "product_description"
        case productCategory = "product_category"
        case productSubCategory = "product_sub_category"
        case productBigCategory = "product_big_category"
        case productCustomizationOptions = "product_customization_options"
    }
    
    var imageType: ImageType {
        let icedCategories: [ProductCategory] = [.coldCoffees, .coldDrinks, .icedTeas]
        if (icedCategories.contains(productCategory)) {return ImageType.iced}
        if (productCategory == .frappuccinoBlendedBeverages) {return ImageType.frappucino}
        return ImageType.hot
    }
    
    static var example: Product = ProductService.shared.getFirstProductInCategory(category: .hotCoffees)
}

enum ProductBigCategory: String, Codable, CaseIterable {
    case drinks = "Drinks"
    case food = "Food"
    case atHomeCoffee = "At Home Coffee"
    case merchandise = "Merchandise"
}

enum ProductCategory: String, Codable, CaseIterable {
    case bakery = "Bakery"
    case coldCoffees = "Cold Coffees"
    case coldCups = "Cold Cups"
    case coldDrinks = "Cold Drinks"
    case frappuccinoBlendedBeverages = "Frappuccino® Blended Beverages"
    case ground = "Ground"
    case hotBreakfast = "Hot Breakfast"
    case hotCoffees = "Hot Coffees"
    case hotDrinks = "Hot Drinks"
    case hotTeas = "Hot Teas"
    case icedTeas = "Iced Teas"
    case lunch = "Lunch"
    case mugs = "Mugs"
    case oatmealYogurt = "Oatmeal & Yogurt"
    case oleato = "Oleato™"
    case other = "Other"
    case snacksSweets = "Snacks & Sweets"
    case tumblers = "Tumblers"
    case vanillaBiscottiWithAlmonds = "Vanilla Biscotti with Almon"
    case viaInstant = "VIA® Instant"
    case wholeBean = "Whole Bean"
}

// MARK: - ProductCustomizationOption
struct ProductCustomizationOption: Codable {
    let isDropdown: Bool
    let defaultValueDropdown: String?
    let options: [String]?
    let defaultValueStepper: String?

    enum CodingKeys: String, CodingKey {
        case isDropdown = "is_dropdown"
        case defaultValueDropdown = "default_value_dropdown"
        case options
        case defaultValueStepper = "default_value_stepper"
    }
}

enum ProductSizeOption: String, Codable, CaseIterable {
    case grande = "Grande"
    case short = "Short"
    case tall = "Tall"
    case trenta = "Trenta"
    case venti = "Venti"
}

let sizeOptionToSize: [ProductSizeOption: String] = [
    .short: "8 fl oz",
    .tall: "12 fl oz",
    .grande: "16 fl oz",
    .venti: "20 fl oz",
    .trenta: "30 fl oz"
]

enum ImageType: String {
    case frappucino = "frap"
    case hot = ""
    case iced = "iced"
}





typealias Products = [Product]





