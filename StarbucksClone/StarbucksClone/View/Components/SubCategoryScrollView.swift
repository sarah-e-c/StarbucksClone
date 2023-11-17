//
//  SubCategoryView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/16/23.
//

import SwiftUI

struct SubCategoryView: View {
    let subcategory: String
    var products: [Product] {
        ProductService.shared.getAllProductsInSubcategory(subCategory: subcategory)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(products[0].productSubCategory ?? "")
                    .font(.title3)
                    .bold()
                Spacer()
                NavigationLink {
                    SubcategoryView(subcategory: subcategory)
                } label: {
                    Text("See all \(products.count)")
                        .bold()
                }
            }.padding()
            Group {
                //if products.count > 2 {
                    ScrollView(.horizontal) {
                        HStack {
                            Spacer()
                            ForEach(products) { product in
                                NavigationLink {
                                
                                } label: {
                                    ProductIconView(product: product, size: .SCROLLSIZE)
                                }
                                
                            }
                        }
                    }
//                } else {
//                     {
//                        ForEach(products) { product in
//                            ProductIconView(product: product)
//                        }
//                    }
//                }
            }
            
        }
    }
}

#Preview {
    NavigationStack {
        SubCategoryView(subcategory: "Lattes")
    }
    
}
