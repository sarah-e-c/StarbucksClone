//
//  MenuView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/17/23.
//

import SwiftUI

struct MenuView: View {
    @StateObject var vm: MenuViewModel
    var body: some View {
        ScrollView {
                ForEach(vm.bigCategories, id: \.self) { bigCategory in
                    VStack {
                    HStack {
                        Text(bigCategory.rawValue)
                            .font(.title3)
                            .bold()
                        Spacer()
                        NavigationLink {
                            FullPageProductsView(vm: vm, products: vm.getAllBigCategoryProducts(bigCategory: bigCategory), title: bigCategory.rawValue)
                        } label: {
                            Text("See all \(vm.getAllBigCategoryProducts(bigCategory: bigCategory).count)")
                                .bold()
                                .foregroundStyle(Color("green"))
                        }
                    }.padding()
                        ForEach(vm.getAllCategoriesInBigCategory(bigCategory: bigCategory), id: \.self) {category in
                            HStack {
                                NavigationLink {
                                    Group {
                                        if vm.categoryHasSubcategories(category: category) {
                                            CategoryView(vm: vm, category: category)
                                        } else {
                                            FullPageProductsView(vm: vm, products: vm.getAllProductsInCategory(category: category), title: category.rawValue)
                                        }
                                    }
                                } label: {
                                    ProductImageView(product: vm.getFirstCategoryProduct(category: category), size: .mini)
                                    Text(category.rawValue)
                                        .foregroundStyle(Color.black)
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
        MenuView(vm: MenuViewModel())
    }
}
