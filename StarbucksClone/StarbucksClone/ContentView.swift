//
//  ContentView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/12/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(ProductService.shared.products[0].productName)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
