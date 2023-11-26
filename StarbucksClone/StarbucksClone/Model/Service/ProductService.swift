//
//  ProductService.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/16/23.
//

import Foundation

class ProductService {
    let products: Products
    let cartItems: [Product] = []
    
    
    init() {
        products = Bundle.main.decode("productToMessWith3.json")
    }
    
    func getAllProductsInSubcategory(subCategory: String) -> [Product] {
        return products.all(where: {$0.productSubCategory == subCategory})
    }
    
    func getAllProductsInCategory(category: ProductCategory) -> [Product] {
        return products.all(where: {$0.productCategory == category})
    }
    
    func getFirstProductInSubcategory(subCategory: String) -> Product? {
        return products.first(where: {$0.productSubCategory == subCategory})
    }
    
    func getFirstProductInCategory(category: ProductCategory) -> Product {
        return products.first(where: {$0.productCategory == category})!
    }
    
    func getFirstProductInBigcategory(bigCategory: ProductBigCategory) -> Product {
        return products.first(where: {$0.productBigCategory == bigCategory})!
    }
    
    func getCategoriesInBigCategory(bigCategory: ProductBigCategory) -> [ProductCategory] {
        switch bigCategory {
        case .atHomeCoffee:
            return [.wholeBean, .ground, .viaInstant]
        case .merchandise:
            return [.coldCups, .tumblers, .mugs, .other]
        case .drinks:
            return [.hotCoffees, .hotTeas, .hotDrinks, .frappuccinoBlendedBeverages, .coldCoffees, .icedTeas, .coldDrinks]
        case .food:
            return [.hotBreakfast, .oatmealYogurt, .bakery, .lunch, .snacksSweets]
        }
    }
    
    func categoryHasSubcategories(category: ProductCategory) -> Bool {
        let noSubCategoryCategories: [ProductCategory] = [.ground, .oatmealYogurt, .oleato, .coldCups, .tumblers, .mugs, .other]
        return !noSubCategoryCategories.contains(category)
    }
    
    func getSubCategoriesInCategory(category: ProductCategory) -> [String?] {
        let productsInCategory = products.all(where: {$0.productCategory == category})
        let productSubCategories = productsInCategory.map { $0.productSubCategory }
        return Array(Set(productSubCategories))
    }
    
    
    
    static var shared = ProductService()
}
