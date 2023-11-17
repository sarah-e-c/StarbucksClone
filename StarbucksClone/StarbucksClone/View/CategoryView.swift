//
//  CategoryView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/16/23.
//

import SwiftUI

struct CategoryView: View {
    let category: ProductCategory
    var body: some View {
        ScrollView {
            ForEach(ProductService.shared.getSubCategoriesInCategory(category: category), id: \.self) { subCategory in
                Group {
                    if let subCategoryUnrapped: String = subCategory {
                        SubCategoryView(subcategory: subCategoryUnrapped)
                        Divider()
                    }
                }
                
            }
        }.navigationBarTitle("\(category.rawValue) (\(3))")
            .navigationBarTitleDisplayMode(.large)
        

    }
}

#Preview {
    NavigationStack {
        CategoryView(category: .bakery)
    }
    
}
