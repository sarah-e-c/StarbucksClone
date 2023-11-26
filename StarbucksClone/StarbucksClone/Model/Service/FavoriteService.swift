//
//  FavoriteService.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/20/23.
//

import Foundation
import SwiftUI

class FavoriteService: ObservableObject {
    var favoriteProducts: [CustomProduct] = []
    @Published var messageAvailable: Bool = false
    @Published var message = ""
    
    
    init() {
        self.favoriteProducts = Bundle.main.decodeTemp("favorites")
        //print(self.favoriteProducts)
    }
    
    
    func toggleFavorite(product: CustomProduct) {
        print("toggling favorites")
        for (index, product_) in self.favoriteProducts.enumerated() {
            if product_.isEqual(product2: product) {
                withAnimation {
                    self.message = "\(product.product.productName) removed from favorites"
                    self.messageAvailable = true
                }
                
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (_) in
                    withAnimation {
                        self.messageAvailable = false
                        self.message = ""
                    }
                })
                favoriteProducts.remove(at: index)
                Bundle.main.encode(favoriteProducts, "favorites")
                
                return
            }
        }
        favoriteProducts.append(product)
        Bundle.main.encode(favoriteProducts, "favorites")
        withAnimation {
            self.message = "\(product.product.productName) added to favorites"
            self.messageAvailable = true
        }

        Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (_) in
            withAnimation {
                self.messageAvailable = false
                self.message = ""
            }
        })
    }
    
    func isFavorite(product: CustomProduct) -> Bool {
        for product_ in favoriteProducts {
            if product.isEqual(product2: product_) {
                return true
            }
        }
        return false
    }
    
    
    
    static var shared = FavoriteService()
}
