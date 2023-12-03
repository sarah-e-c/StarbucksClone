//
//  CategoryView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/16/23.
//

import SwiftUI

struct CategoryView: View {
    @ObservedObject var vm: MenuViewModel
    @ObservedObject var storeAndCartVm: StoreAndCartViewModel
    let category: ProductCategory
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("\(category.rawValue) (\(ProductService.shared.getAllProductsInCategory(category: category).count))")
                        .font(.largeTitle)
                        .padding()
                        .bold()
                    Spacer()
                }
                HeaderEdgeDivider()
            }.background(Color.white)
                .padding(.bottom, -10)


            ScrollView {
                ForEach(vm.getSubcategoriesInCategory(category: category), id: \.self)
                { subCategory in
                    Group {
                        if let subCategoryUnrapped: String = subCategory {
                            ProductScrollView(vm: vm, storeAndCartVm: storeAndCartVm, products: vm.getAllProductsInSubCategory(subCategory: subCategoryUnrapped, category: category), title: subCategoryUnrapped)
                            Divider()
                        }
                    }
                    
                }
            }
            StoreAndCartView(vm: storeAndCartVm)
        }.background(Color.scrollbackground).padding(.top, -12)
        

    }
}

#Preview {
    NavigationStack {
        CategoryView(vm: MenuViewModel(), storeAndCartVm: StoreAndCartViewModel(), category: .bakery)
    }
    
}
