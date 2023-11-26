//
//  HistoryView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/21/23.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var vm: MenuViewModel
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading)  {
            if vm.getHistory().isEmpty {
                Image("nohistory")
                    .resizable()
                    .scaledToFit()
                Text("When history repeats itself.")
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                Text("Previous orders will appear here to quickly order again.")
                    
                    .opacity(0.7)
                    .padding(.horizontal)
                Spacer()
            } else {
                ForEach(vm.getHistory().reversed()) {order in
                    HStack {
                        Text(order.formattedDate + " • MOBILE")
                            .font(.caption)
                            .opacity(0.8)
                            .bold()
                        Spacer()
                        Button {
                            vm.addProductsToCart(products: order.products)
                        } label: {
                            Text("Add all")
                                .foregroundStyle(Color("green"))
                                .bold()
                        }
                    }.padding()
                        .background(Color.darkgray)
                    VStack {
                        ForEach(order.products.indices.dropLast(), id: \.self) {i in
                            ProductRectangleView(isLight: true, product: order.products[i], vm: StoreAndCartViewModel())
                            Divider()
                        }
                        ProductRectangleView(isLight: false, product: order.products.last!, vm: StoreAndCartViewModel())
                    }
                }
            }

            }
        }.background(Color.scrollbackground)
    }
}

#Preview {
    HistoryView(vm: MenuViewModel())
}
