//
//  MenuViewModel.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/17/23.
//

import Foundation

class MenuViewModel: ObservableObject {
    let products: Products
    var currentProduct: Product
    
    init() {
        products = ProductService.shared.products
        currentProduct = products[0]
    }
    
    var bigCategories: [ProductBigCategory] {
        return ProductBigCategory.allCases
    }
    
    var categories: [ProductCategory] {
        return ProductCategory.allCases
    }
    

    func getFirstBigCategoryProduct(bigCategory: ProductBigCategory) -> Product {
        return products.first(where: {$0.productBigCategory == bigCategory})!
    }
    
    func getAllProductsInCategory(category: ProductCategory) -> Products {
        return products.all(where: {$0.productCategory == category})
    }
    
    func getSubcategoriesInCategory(category: ProductCategory) -> [String?] {
        return ProductService.shared.getSubCategoriesInCategory(category: category)
    }
    
    func categoryHasSubcategories(category: ProductCategory) -> Bool {
        return ProductService.shared.categoryHasSubcategories(category: category)
    }
    
    func getAllBigCategoryProducts(bigCategory: ProductBigCategory) -> Products {
        return products.all(where: {$0.productBigCategory == bigCategory})
    }
    
    func getFirstCategoryProduct(category: ProductCategory) -> Product {
        return products.first(where: {$0.productCategory == category})!
    }
    
    func getAllCategoriesInBigCategory(bigCategory: ProductBigCategory) -> [ProductCategory] {
        return ProductService.shared.getCategoriesInBigCategory(bigCategory: bigCategory)
    }
    
    func getAllProductsInSubCategory(subCategory: String, category: ProductCategory) -> Products {
        return ProductService.shared.getAllProductsInSubcategory(subCategory: subCategory).all(where: {$0.productCategory == category})
    }
    
    func getFavoriteProducts() -> [CustomProduct] {
        return FavoriteService.shared.favoriteProducts
    }
    
    func getHistory() -> [Order] {
        return HistoryService.shared.history
    }
    
    func addProductsToCart(products: [CustomProduct]) {
        for product in products {
            CartService.shared.addProductToOrder(product: product)
        }
        
    }
    
}
