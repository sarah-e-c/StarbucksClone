//
//  FavoritesView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/21/23.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var vm: MenuViewModel
    @ObservedObject var storeAndCartVm: StoreAndCartViewModel
    var body: some View {
        Group{
            if vm.getFavoriteProducts().isEmpty {
                VStack(alignment: .leading) {
                    Image("nofavorites")
                        .resizable()
                        .scaledToFit()
                        
                    Text("Favorite items")
                        .font(.title)
                        .bold()
                        .padding([.top, .horizontal])
                    Text("Use the heart to save customizations. Your favorites will appear here to order again.")
                        .opacity(0.7)
                        .padding(.horizontal)
                    Spacer()
                }
                    .background(Color.scrollbackground)

                
            } else {
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(vm.getFavoriteProducts().reversed(), id: \.id) {product in
                            ProductRectangleView(isLight: true, product: product, vm: storeAndCartVm)
                                .padding(.horizontal)
                            Divider()
                        }
                    }
                }.background(Color.scrollbackground)
            }
        }
    }
}

#Preview {
    FavoritesView(vm: MenuViewModel(), storeAndCartVm: StoreAndCartViewModel())
}
