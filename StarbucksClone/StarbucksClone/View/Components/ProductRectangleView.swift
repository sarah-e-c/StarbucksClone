//
//  ProductRectangleView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/20/23.
//

import SwiftUI

struct ProductRectangleView: View {
    let isLight: Bool
    var product: CustomProduct
    @ObservedObject var vm: StoreAndCartViewModel
    @ObservedObject var cartService =  CartService.shared
    
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                ProductImageView(product: product.product, size: .mini)
            }
            
            ProductInfoAndButtons(isLight: isLight, product: product,  vm: vm)
                .padding()
            if !isLight {
                Spacer()
                Text("$5.95")
                    .bold()
                    .padding(.top)
                Spacer()
            } else {
                Spacer()
            }
        }.padding()
    }
}

#Preview {
    ProductRectangleView(isLight: false, product: CustomProduct.example, vm:StoreAndCartViewModel())
}

struct ProductInfoAndButtons: View {
    var isLight: Bool
    var product: CustomProduct
    
    @ObservedObject var vm: StoreAndCartViewModel
    @State private var isHeartShowing = true
    
    init(isLight: Bool, product: CustomProduct, vm: StoreAndCartViewModel) {
        self.isLight = isLight
        self.product = product
        self.vm = vm
        //self.isHeartShowing = vm.isProductFavorited(product: self.product)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(product.product.productName)
                .font(.title2)
            Text("\(product.sizeOption?.rawValue ?? "") \(isLight ? "" : sizeOptionToSize[product.sizeOption ?? .grande] ?? "")")
            ForEach(product.modifiedOptions, id:\.id) {option in
                Text(option.label)
            }
            Text("\(product.product.productCalories ?? "") Calories")
                .opacity(0.6)
            if !isLight {
                ZStack {
                    Text("200    item")
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .offset(CGSize(width: -3.0, height: 0))
                } .opacity(0.6)
                    
            }


            HStack {
                Button {
                    print("Button Pressed")
                    vm.favoriteToggle(product: product)
                    // yes this is scuffed but its a struggle
                    Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false, block: {(_) in isHeartShowing.toggle(); vm.updated += 1})
                        
                } label: {
                    Image(systemName: vm.isProductFavorited(product: product) ? "heart.fill" : "heart")
                        .foregroundStyle(vm.isProductFavorited(product: product) ? .green : .black)
                        .opacity(isHeartShowing ? 1.0 : 0.99)
                }
                Button {
                    vm.addProduct(product: product)
                } label: {
                    Image(systemName: "plus.circle")
                        .foregroundStyle(.black)
                        .opacity(0.5)
                }
                if !isLight {
                    Button {
                        vm.removeProduct(product: product)
                    } label: {
                        Image(systemName: "minus.circle")
                            .foregroundStyle(.black)
                            .opacity(0.5)
                    }
                }
            }.padding(.top)
        }
    }
}
