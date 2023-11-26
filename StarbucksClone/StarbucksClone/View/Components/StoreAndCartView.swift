//
//  StoreAndCartView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/19/23.
//

import SwiftUI

struct StoreAndCartView: View {
    @StateObject var vm: StoreAndCartViewModel
    @State var iconShowing = false
    @ObservedObject var sheetManager = SheetManager.shared
    
    // thisi s really just here for the notifications
    @ObservedObject var service = CartService.shared
    @ObservedObject var favservice = FavoriteService.shared
    var body: some View {
        ZStack {
            VStack {
                MessageView(vm: vm)
                
                HStack {
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Pickup store")
                                    .font(.caption)
                                    .opacity(0.7)
                                Text("Franklin St & Columbia St: 0.6 mi")
                                
                            }.foregroundColor(.white)
                                .padding()
                            Spacer()
                            Image(systemName: "chevron.down")
                                .font(.caption)
                                .padding(.top)
                        }
                        Rectangle().foregroundStyle(.white).frame(height: 1).opacity(0.3).offset(x:0, y:-10)
                    }
                    Button {
                        sheetManager.showConfirmOrderSheet()
                        
                    } label: {
                        ZStack {
                            Image(vm.numProducts == 0 ? "bagicon" : "bagiconfill")
                                .renderingMode(.template)
                                .foregroundStyle(.white)
                                .shadow(radius: 10)
                                .opacity(0.8)
                                .padding()
                            Text("\(vm.numProducts)")
                                .padding(.top, 4)
                                .foregroundStyle(vm.numProducts == 0 ? .white : .darkgreen)
                        }

                    }
                }.frame(height:60)
                    .foregroundStyle(.white)
                .background(Rectangle().foregroundStyle(Color("darkgreen")))
                
            }
            Group {
                if vm.cartRecentlyChanged {
                    Image("locationicon")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.white)
                        .frame(width: 40)
                        .shadow(radius: 10)
                        .offset(y: 17)
                        
                    ProductImageView(product: vm.mostRecentProduct, size: .superMini)
                        .offset(y:12)
                        
                }
            }.offset(x:165, y:-50)
        }.padding(.top, -8)
            .sheet(isPresented: $sheetManager.confirmOrderSheetShowing, content: {
                ConfirmOrderView(vm: vm)
            })
    }
}

#Preview {
    StoreAndCartView(vm: StoreAndCartViewModel())
}

