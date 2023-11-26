//
//  StoreAndCartViewModel.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/19/23.
//

import Foundation

import SwiftUI

class StoreAndCartViewModel: ObservableObject {
    var cartService = CartService.shared
    @Published var updated = 0
    @Published var currentProduct = Product.example

    
    
    func getProductsInCart() -> [CustomProduct] {
        return CartService.shared.cart
    }
    var numProducts: Int {
        return CartService.shared.cart.count
    }
    var mostRecentProductImagePath: String {
        guard !CartService.shared.cart.isEmpty else {return ""}
        return CartService.shared.cart[CartService.shared.cart.count - 1].product.productName
    }
    var mostRecentProduct: Product {
        guard !CartService.shared.cart.isEmpty else {return Product.example}
        return CartService.shared.cart[CartService.shared.cart.count - 1].product
    }
    
    var cartRecentlyChanged: Bool {
        return CartService.shared.cartRecentlyChanged
    }
    
    func favoriteToggle(product: CustomProduct)  {
        FavoriteService.shared.toggleFavorite(product: product)
    }
    
    func isProductFavorited(product: CustomProduct) -> Bool {
        return FavoriteService.shared.isFavorite(product: product)
    }
    
    func removeProduct(product: CustomProduct) {
        CartService.shared.removeProduct(product: product)
        updated += 1
    }
    
    func addProduct(product: CustomProduct) {
        CartService.shared.addProductToOrder(product: product)
        updated += 1
    }
    
    func checkout() {
        HistoryService.shared.addToHistory(products: CartService.shared.cart)
        CartService.shared.cart = []
        updated += 1
    }
    
    func mostRecentOrder() -> [CustomProduct] {
        return HistoryService.shared.history.last?.products ?? []
    }
    
    var message: String? {
        if CartService.shared.messageAvailable {
            return CartService.shared.message
        } else if FavoriteService.shared.messageAvailable {
            return FavoriteService.shared.message
        }
        else {
            return nil
        }
    }
    
    
    
}
