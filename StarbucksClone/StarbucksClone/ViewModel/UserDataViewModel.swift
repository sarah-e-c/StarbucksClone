//
//  UserDataViewModel.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/28/23.
//

import Foundation

class UserDataViewModel: ObservableObject {
    var stars: Int {
        StarAndMoneyService.shared.stars
    }
    
    var formattedDollars: String {
        StarAndMoneyService.shared.formattedDollars
    }
}
