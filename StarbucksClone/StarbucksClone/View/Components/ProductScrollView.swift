//
//  SubCategoryView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/16/23.
//

import SwiftUI

struct ProductScrollView: View {
    @ObservedObject var vm: MenuViewModel
    @ObservedObject var sheetManager = SheetManager.shared
    @ObservedObject var storeAndCartVm: StoreAndCartViewModel
    var products: [Product]
    var title: String
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.title3)
                    .bold()
                Spacer()
                NavigationLink {
                    FullPageProductsView(vm: vm, storeAndCartVm: storeAndCartVm, products: products, title: title)
                } label: {
                    Text("See all \(products.count)")
                        .bold()
                        .foregroundStyle(Color("green"))
                }
            }.padding()
            Group {
                //if products.count > 2 {
                    ScrollView(.horizontal) {
                        HStack {
                            Spacer()
                            ForEach(products) { product in
                                Button {
                                    vm.currentProduct = product
                                    sheetManager.showProductSheet()
                                } label: {
                                    ProductIconView(product: product, size: .scrollSize)
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
            
        }.sheet(isPresented: $sheetManager.productSheetShowing, content: {
            ProductView(vm: ProductViewModel(product: vm.currentProduct), storeAndCartVm: storeAndCartVm)
        })
    }
}

#Preview {
    NavigationStack {
        ProductScrollView(vm: MenuViewModel(), storeAndCartVm: StoreAndCartViewModel(), products: ProductService.shared.getAllProductsInSubcategory(subCategory: "Lattes"), title: "Lattes")
    }
    
}
