//
//  ThanksForOrderView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/21/23.
//

import SwiftUI

struct ThanksForOrderView: View {
    @ObservedObject var vm: StoreAndCartViewModel
    @Environment(\.dismiss) var dismiss
    @ObservedObject var sheetManager = SheetManager.shared
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .opacity(0.5)
                        .font(.title2)
                        .foregroundStyle(Color.black)
                        .padding(.bottom, 5)
                        
                }
               
                Spacer()
            }
            Text("See you soon, John!")
                .font(.largeTitle)
                .bold()
               
            Text("Estimated pickup is at 11:25 AM")
                .opacity(0.7)
                .padding(.bottom)
                
            HeaderEdgeDivider()
                .padding(.horizontal, -15)
            Text("Franklin St. and Columbia St.")
                .bold()
                .padding(.top)
            Text("13306 A St. John's Church Road")
                .padding(.bottom)
            Image("ordermap")
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding(.bottom)
            HStack {
                Text("\(vm.mostRecentOrder().count) items in your order")
                    .bold()
                Spacer()
                Text("View receipt")
                    .bold()
                    .foregroundStyle(Color("green"))
            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(vm.mostRecentOrder()) { product in
                        ProductImageView(product: product.product, size: .mini)
                    }
                }
            }.padding(.bottom)
            Text("Ask Siri to reorder your recent orders")
                .font(.caption)
                .opacity(0.7)
            HStack {
                Text("Say")
                    .opacity(0.7)
                Text("\"Order Starbucks\"").bold()
                Spacer()
            }.padding()
                .background(Color.scrollbackground)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .padding(.bottom)
            HStack(alignment: .top) {
                Image(systemName: "door.left.hand.open")
                    .font(.title)
                    .padding()
                VStack(alignment: .leading) {
                    Text("In-store pickup")
                        .bold()
                    Text("Head to the pickup counter and look for an order for John. If you have questions, just ask a barista.")
                        .font(.subheadline)
                        .opacity(0.8)
                }.padding(.vertical)
                Spacer()
            }.padding(.vertical, 4)
                .background(Color.scrollbackground)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            Spacer()
        }.padding()
    }
}

#Preview {
    ThanksForOrderView(vm: StoreAndCartViewModel())
}

