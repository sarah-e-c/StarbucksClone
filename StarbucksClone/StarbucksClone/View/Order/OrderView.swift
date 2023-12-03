//
//  OrderView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/18/23.
//

import SwiftUI

struct OrderView: View {
    @StateObject var vm = MenuViewModel()
    @ObservedObject var storeAndCartVM: StoreAndCartViewModel
    @ObservedObject var sheetManager = SheetManager.shared
    var body: some View {
        VStack(alignment: .leading) {
            Text("Order")
                .font(.largeTitle)
                .bold()
                .padding()
            TopTabView(labels: ["Menu", "Featured", "Previous", "Favorites"], views: [MenuView(vm: vm, storeAndCartVm: storeAndCartVM), FeaturedView(vm: vm, storeAndCartVm: storeAndCartVM), HistoryView(vm: vm, storeAndCartVm: storeAndCartVM), FavoritesView(vm: vm, storeAndCartVm: storeAndCartVM)])
            StoreAndCartView(vm: storeAndCartVM)
        }.sheet(isPresented: $sheetManager.productSheetShowing) {
            ProductView(vm: ProductViewModel(product: vm.currentProduct), storeAndCartVm: storeAndCartVM)
        }.onAppear(perform: {
            if storeAndCartVM.selectedLocation == nil {
                sheetManager.showMapSheet()
            }
        })

    }
}

struct FeaturedView: View {
    @ObservedObject var vm: MenuViewModel
    @ObservedObject var storeAndCartVm: StoreAndCartViewModel
    var body: some View {
        ScrollView {
            VStack {
                ProductScrollView(vm: vm, storeAndCartVm: storeAndCartVm, products: vm.getAllProductsInSubCategory(subCategory: "Lattes", category: .hotCoffees), title: "Festive Flavors")
                Divider()
                ProductScrollView(vm: vm, storeAndCartVm: storeAndCartVm, products: vm.getAllProductsInSubCategory(subCategory: "Lattes", category: .hotCoffees), title: "Icy Festivity")
                Divider()
                ProductScrollView(vm: vm, storeAndCartVm: storeAndCartVm, products: vm.getAllProductsInSubCategory(subCategory: "Lattes", category: .hotCoffees), title: "Toasty Favorites")
                Divider()
                ProductScrollView(vm: vm, storeAndCartVm: storeAndCartVm, products: vm.getAllProductsInCategory(category: .ground), title: "Holiday At-Home coffee")
                Divider()
            }
        }.background(Color.scrollbackground)

    }
}

#Preview {
    NavigationStack {
        OrderView(storeAndCartVM: StoreAndCartViewModel())
    }
}


