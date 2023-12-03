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
    @ObservedObject var storeAndCartVm: StoreAndCartViewModel
    
    let products: [Product]
    let title: String
    

    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .bold()
                .padding()
            HeaderEdgeDivider()
                
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
                    .padding(.top)
            }.background(Color.scrollbackground).padding(.top, -10)
                

            StoreAndCartView(vm: storeAndCartVm)
        }

    }
}

#Preview {
    NavigationStack {
        FullPageProductsView(vm: MenuViewModel(), storeAndCartVm: StoreAndCartViewModel(), products: ProductService.shared.getAllProductsInSubcategory(subCategory: "Lattes"), title: "Lattes")
    }
    
}
