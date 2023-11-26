//
//  SubcategoryView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/17/23.
//

import SwiftUI

struct FullPageProductsView: View {
    @ObservedObject var vm: MenuViewModel
    @ObservedObject var sheetManager = SheetManager.shared
    
    let products: [Product]
    let title: String
    

    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    ForEach(products) { product in
                        Button {
                            vm.currentProduct = product
                            sheetManager.showProductSheet()
                        } label: {
                            ProductIconView(product: product, size: .fullPageSize)
                        }
                    }
                }).padding(.horizontal)
            }.navigationTitle(title)
                .navigationBarTitleDisplayMode(.large)

            StoreAndCartView(vm: StoreAndCartViewModel())
        }

    }
}

#Preview {
    NavigationStack {
        FullPageProductsView(vm: MenuViewModel(), products: ProductService.shared.getAllProductsInSubcategory(subCategory: "Lattes"), title: "Lattes")
    }
    
}
