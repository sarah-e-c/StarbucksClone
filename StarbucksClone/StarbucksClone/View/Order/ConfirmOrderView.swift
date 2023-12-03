//
//  ConfirmOrderView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/20/23.
//

import SwiftUI

struct ConfirmOrderView: View {
    @ObservedObject var vm: StoreAndCartViewModel
    @State private var isFullShowing = true
    @ObservedObject var sheetManager = SheetManager.shared
    
    init(vm: StoreAndCartViewModel) {
        self.vm = vm
    }
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            VStack {
                VStack(alignment: .leading) {
                    ToolbarView(vm: vm, isFullShowing: isFullShowing)
                    Group {
                        if isFullShowing {
                            FullToolbarView(vm: vm)
                        }
                    }
                }.padding().background(Color.darkgreen)
                    .foregroundStyle(.white)
                    .padding(.vertical, -8)
                
                if vm.numProducts > 0 {
                    CustomScrollView {
                        VStack {
                            ForEach(vm.getProductsInCart().indices.dropLast(), id: \.self) {i in
                                ProductRectangleView(isLight: false, product: vm.getProductsInCart()[i], vm: vm)
                                Divider()
                            }
                            if !vm.getProductsInCart().isEmpty {
                                ProductRectangleView(isLight: false, product: vm.getProductsInCart().last!, vm: vm)
                            }
                            
                            VStack(alignment: .leading) {
                                Text("YOU MAY ALSO LIKE")
                                    .opacity(0.7)
                                    .bold()
                                    .padding([.top, .horizontal])
                                    .font(.caption2)
                                ScrollView(.horizontal) {
                                    HStack {
                                        Spacer()
                                        ForEach(ProductService.shared.getAllProductsInCategory(category: .bakery)) { item in
                                            Button {
                                                vm.currentProduct = item
                                                sheetManager.showAlternateProductSheet()
                                            } label: {
                                                ProductIconView(product: item, size: .smallScrollSize)
                                            }
                                            
                                        }
                                    }
                                }
                            }.font(.caption)
                                .background(Color.darkgray)
                                .padding(.bottom)
                                .padding(.bottom)
                            CostBreakdownView()
                            Divider()
                                .padding(.bottom, 35)
                        }.padding(.top)
                    } onScroll: { num in
                        if num < -150 && vm.numProducts > 1 {
                            withAnimation {
                                isFullShowing = false
                            }
                            
                        } else {
                            withAnimation {
                                isFullShowing = true
                            }
                        }
                    }
                    MessageView(vm: vm)
                        .padding(.top, -8)
                } else {
                    NoProductsView()
                    
                        
                }
            }
            if vm.numProducts > 0 {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            vm.checkout()
                            sheetManager.showThankYouSheet()
                        } label: {
                            GreenButton("Checkout \(vm.formattedCost)")
                        }
                    }
                }
            }
        }.sheet(isPresented: $sheetManager.alternateProductSheetShowing, content: {
            ProductView(vm: ProductViewModel(product: vm.currentProduct), storeAndCartVm: vm, isAlternate: true)
        }).sheet(isPresented: $sheetManager.thankYouSheetShowing) {
            ThanksForOrderView(vm: vm)
        }

    }
}


#Preview {
    ConfirmOrderView(vm: StoreAndCartViewModel())
        .onAppear(perform: {
            StoreAndCartViewModel().addProduct(product: CustomProduct.example)
        })
}

private struct ToolbarView: View {
    @ObservedObject var vm: StoreAndCartViewModel
    @Environment(\.dismiss) var dismiss
    let isFullShowing: Bool
    var body: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.down")
                    .opacity(0.7)
            }
            Group {
                if !isFullShowing {
                    Spacer()
                    Text("Review Order (2)")
                        .font(.headline)
                    Spacer()
                } else {
                    Spacer()
                }
            }
            Text("\(vm.stars)")
            Image(systemName: "star.fill")
                .font(.caption)
        }
    }
}

private struct FullToolbarView: View {
    @ObservedObject var vm: StoreAndCartViewModel
    var body: some View {
        Text("Review Order (\(vm.numProducts))")
            .font(.title2)
            .bold()
            .padding(.top)
        Text("Prep time: 6-9 min")
            .opacity(0.8)
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Pickup store")
                        .font(.caption)
                        .opacity(0.7)
                    Text("\(vm.selectedLocation?.name ?? "No location selected"):  \(vm.getFormattedLocationDistanceFromUserLocation(lat: Double(vm.selectedLocation?.latitude ?? "") ?? vm.CHAPEL_HILL_LATITUDE, long: Double(vm.selectedLocation?.longitude ?? "") ?? vm.CHAPEL_HILL_LONGITUDE)) km")
                    
                }.foregroundColor(.white)
                Spacer()
                Image(systemName: "chevron.down")
                    .font(.caption)
                    .padding(.top)
            }
            Rectangle().foregroundStyle(.white).frame(height: 1).opacity(0.3).offset(x:0, y:-10)
        }
        Text("Pickup Method")
            .font(.caption)
            .opacity(0.7)
            .padding(.bottom)
        VStack(alignment: .center) {
            Image(systemName: "door.left.hand.open")
            Text("In store")
                .font(.caption)
        }

    }
}

struct NoProductsView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .leading) {
            Image("noitems")
                .resizable()
                .scaledToFit()
                
            Group {
                Text("Start your next order")
                    .font(.title)
                    .bold()
                Text("As you add menu items, they'll appear here. You'll have a chance to review before placing your order.")
                    .opacity(0.7)
                Button {
                    dismiss()
                } label: {
                    SmallGreenButton("Add items")
                }
                
            }.padding(5)
                .padding(.horizontal, 10)
            VStack {
                Spacer()
            }
        }.background(Color.scrollbackground)
    }
}

struct CostBreakdownView: View {
    var body: some View {
        VStack {
            ZStack {
                Text("..........................................")
                    .opacity(0.2)
                    .offset(y:1)
                HStack {
                    Text("Subtotal")
                        .opacity(0.9)
                        .background(Color.white)
                    Spacer()
                    Text("$6.25")
                        .bold()
                        .background(Color.white)
                }.font(.caption)
            }
            ZStack {
                Text("..........................................")
                    .opacity(0.2)
                    .offset(y:1)
                HStack {
                    Text("Tax")
                        .opacity(0.9)
                        .background(Color.white)
                    Spacer()
                    Text("0.47")
                        .bold()
                        .background(Color.white)
                }.font(.caption)
            }
            ZStack {
                Text("..........................................")
                    .opacity(0.2)
                    .offset(y:4)
                HStack {
                    Text("Total")
                        .font(.title3)
                        .bold()
                        .background(Color.white)
                    Spacer()
                    Text("$6.72")
                        .font(.title3)
                        .bold()
                        .background(Color.white)
                }
            }
                .padding(.bottom, 35)
            
                
            
        }.padding(.leading, 130)
    }
}
