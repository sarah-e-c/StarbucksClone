//
//  HistoryModel.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/20/23.
//

import Foundation

struct Order: Identifiable, Codable {
    var id = UUID()
    let products: [CustomProduct]
    let date: Date
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d h:mm a"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return dateFormatter.string(from: date).uppercased()
    }
}

