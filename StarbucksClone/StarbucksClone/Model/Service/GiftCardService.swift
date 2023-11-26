//
//  GiftCardService.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/21/23.
//

import Foundation

class GiftCardService {
    let giftCards: [GiftCard]
    init() {
        giftCards = Bundle.main.decode("finalgiftcarddata.json")
    }
    
    static var shared = GiftCardService()
}
