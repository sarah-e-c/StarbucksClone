//
//  StarAndMoneyService.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/28/23.
//

import Foundation

class StarAndMoneyService {
    var dollarsAndCents: Int // this is represented as 100 * dollar amount
    var stars: Int
    
    let starsKey = "stars"
    let dollarsKey = "dollars"
    
    var formattedDollars: String {
        Utils.formatIntToDollars(number: dollarsAndCents)
    }
    
    init() {
        dollarsAndCents = UserDefaults.standard.integer(forKey: dollarsKey)
        if (dollarsAndCents == 0) {dollarsAndCents = 6999}
        stars = UserDefaults.standard.integer(forKey: starsKey)
        if (stars == 0) {stars = 2}
    }
    
    func buy_items(dollarAmount: Int) {
        dollarsAndCents -= dollarAmount
        UserDefaults.standard.setValue(dollarsAndCents, forKey: dollarsKey)
        
        stars += dollarAmount/200 // one star for every 2 dollars
        UserDefaults.standard.setValue(stars, forKey: starsKey)
    }
    
    
    
    static var shared = StarAndMoneyService()
}
