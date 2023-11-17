//
//  SubcategoryView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/17/23.
//

import SwiftUI

struct SubcategoryView: View {
    
    let subcategory: String
    
    var products: Products {
        ProductService.shared.getAllProductsInSubcategory(subCategory: subcategory)
    }
    
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, content: {
                ForEach(products) { product in
                    ProductIconView(product: product, size: .FULLPAGESIZE)
                }
            })
        }.navigationTitle(subcategory)
            .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        SubcategoryView(subcategory: "Lattes")
    }
    
}
