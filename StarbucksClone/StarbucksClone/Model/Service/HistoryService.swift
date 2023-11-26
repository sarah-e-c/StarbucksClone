//
//  HistoryService.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/20/23.
//

import Foundation

class HistoryService {
    @Published var history: [Order] = []
    
    init(){
        self.history = Bundle.main.decodeTemp("history")
        //print(self.history)
    }
    
    func addToHistory(products: [CustomProduct]) {
        history.append(Order(products: products, date: Date.now))
        Bundle.main.encode(history, "history")
    }
    
    static var shared = HistoryService()
}
