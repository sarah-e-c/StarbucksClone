//
//  CartService.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/18/23.
//

import Foundation
import SwiftUI


class CartService: ObservableObject {
    @Published var cart: [CustomProduct] = []
    @Published var cartRecentlyChanged = false
    @Published var messageAvailable = false
    @Published var message: String = ""
    
    init() {}

    func addProductToOrder(product: CustomProduct) {
        cart.append(product)
        withAnimation {
            cartRecentlyChanged = true
            self.messageAvailable = true
        }
        
        
        self.message = "\(product.product.productName) added"
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
            withAnimation {
                self.cartRecentlyChanged = false
                self.messageAvailable = false
            }
            self.message = ""
            
        }
        
    }
    
    func removeProduct(product: CustomProduct) {
        for (index, item) in cart.enumerated() {
            if item.isEqual(product2: product) {
                cart.remove(at: index)
                withAnimation {
                    cartRecentlyChanged = true
                    self.message = "\(product.product.productName) removed"
                    self.messageAvailable = true
                }
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
                    withAnimation {
                        self.cartRecentlyChanged = false
                        self.message = ""
                        self.messageAvailable = false
                    }
                }
                return
            }
        }
    }
    
    static var shared = CartService()
    
}
