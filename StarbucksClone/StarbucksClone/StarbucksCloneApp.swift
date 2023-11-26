//
//  StarbucksCloneApp.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/12/23.
//

import SwiftUI

@main
struct StarbucksCloneApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: {
                    FavoriteService.shared = FavoriteService()
                    HistoryService.shared = HistoryService()
                })
        }
    }
}
