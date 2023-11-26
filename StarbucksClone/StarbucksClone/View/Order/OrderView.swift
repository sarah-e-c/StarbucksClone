//
//  OrderView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/18/23.
//

import SwiftUI

struct OrderView: View {
    @StateObject var vm = MenuViewModel()
    @StateObject var storeAndCartVM = StoreAndCartViewModel()
    @ObservedObject var sheetManager = SheetManager.shared
    var body: some View {
        VStack(alignment: .leading) {
            Text("Order")
                .font(.largeTitle)
                .bold()
                .padding()
            TopTabView(labels: ["Menu", "Featured", "Previous", "Favorites"], views: [MenuView(vm: vm), FeaturedView(vm: vm), HistoryView(vm: vm), FavoritesView(vm: vm)])
            StoreAndCartView(vm: storeAndCartVM)
        }.sheet(isPresented: $sheetManager.productSheetShowing) {
            ProductView(vm: ProductViewModel(product: vm.currentProduct))
        }

    }
}

struct FeaturedView: View {
    @ObservedObject var vm: MenuViewModel
    var body: some View {
        ScrollView {
            VStack {
                ProductScrollView(vm: vm, products: vm.getAllProductsInSubCategory(subCategory: "Lattes", category: .hotCoffees), title: "Festive Flavors")
                Divider()
                ProductScrollView(vm: vm, products: vm.getAllProductsInSubCategory(subCategory: "Lattes", category: .hotCoffees), title: "Icy Festivity")
                Divider()
                ProductScrollView(vm: vm, products: vm.getAllProductsInSubCategory(subCategory: "Lattes", category: .hotCoffees), title: "Toasty Favorites")
                Divider()
                ProductScrollView(vm: vm, products: vm.getAllProductsInCategory(category: .ground), title: "Holiday At-Home coffee")
                Divider()
            }
        }.background(Color.scrollbackground)

    }
}

#Preview {
    NavigationStack {
        OrderView()
    }
}


