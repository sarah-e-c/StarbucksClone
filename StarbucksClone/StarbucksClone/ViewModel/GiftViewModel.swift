//
//  GiftViewModel.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/21/23.
//
import Foundation

class GiftViewModel: ObservableObject {
    func getCardImageString(_ card: GiftCard) -> String {
        return String(card.image.split(separator: ".")[0])
    }
    
    func getCardsInCategory(_ category: GiftCategory) -> [GiftCard] {
        return GiftCardService.shared.giftCards.all(where: {$0.category == category})
    }
    
    func getGiftCategories() -> [GiftCategory] {
        return GiftCategory.allCases
    }
}
