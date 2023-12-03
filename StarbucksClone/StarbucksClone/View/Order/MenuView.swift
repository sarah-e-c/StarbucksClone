//
//  MenuView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/17/23.
//

import SwiftUI

struct MenuView: View {
    @StateObject var vm: MenuViewModel
    @ObservedObject var storeAndCartVm: StoreAndCartViewModel
    var body: some View {
        ScrollView {
                ForEach(vm.bigCategories, id: \.self) { bigCategory in
                    VStack() {
                    HStack {
                        Text(bigCategory.rawValue)
                            .font(.title2)
                            .bold()
                        Spacer()
                        NavigationLink {
                            FullPageProductsView(vm: vm, storeAndCartVm: storeAndCartVm, products: vm.getAllBigCategoryProducts(bigCategory: bigCategory), title: bigCategory.rawValue)
                        } label: {
                            Text("See all \(vm.getAllBigCategoryProducts(bigCategory: bigCategory).count)")
                                .bold()
                                .foregroundStyle(Color("green"))
                        }
                    }.padding()
                        ForEach(vm.getAllCategoriesInBigCategory(bigCategory: bigCategory), id: \.self) {category in
                            HStack {
                                NavigationLink {
                                    if vm.categoryHasSubcategories(category: category) {
                                        CategoryView(vm: vm, storeAndCartVm: storeAndCartVm, category: category)
                                    } else {
                                        FullPageProductsView(vm: vm, storeAndCartVm: storeAndCartVm, products: vm.getAllProductsInCategory(category: category), title: category.rawValue)
                                    }
                                } label: {
                                    ProductImageView(product: vm.getFirstCategoryProduct(category: category), size: .mini)
                                
                                    Text(category.rawValue)
                                        .foregroundStyle(Color.black)
                                        .font(.title3)
                                        .multilineTextAlignment(.leading)
                                    
                                    
                                    Spacer()
                                }
                                
                            }.padding(.horizontal)
                        }
                    }
                }
        }.background(Color.scrollbackground)
            
    }
}

#Preview {
    NavigationStack {
        MenuView(vm: MenuViewModel(), storeAndCartVm: StoreAndCartViewModel())
    }
}
