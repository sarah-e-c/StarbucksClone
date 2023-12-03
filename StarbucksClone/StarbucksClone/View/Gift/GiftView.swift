//
//  GiftView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/21/23.
//

import SwiftUI

struct GiftView: View {
    @ObservedObject var vm: GiftViewModel
    var body: some View {
        VStack {
            HStack {
                Text("Gift cards")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                Spacer()
            }
            HeaderEdgeDivider()
                
                
            ScrollView {
                HStack {
                    Image(systemName: "creditcard")
                        .font(.title)
                        .opacity(0.7)
                    VStack(alignment: .leading) {
                        Text("Got a gift card? Add it here")
                            .bold()
                        ZStack {
                            Text("earns 2    per $1")
                            Image(systemName: "star.fill")
                                .offset(x:2)
                                .font(.caption)
                        }
                    }.opacity(0.7)
                    Spacer()
                }.padding()
                    .background(Color.white.shadow(radius: 10, y:5))
                    .clipShape(RoundedRectangle(cornerRadius: 5.0))
                    .padding()
                VStack(alignment: .leading) {
                    // featured views
                    ForEach(vm.getGiftCategories(), id:\.rawValue) { category in
                        GiftCategoryScrollView(vm: vm, category: category, isFeatured: category == .featured)
                    }

                }
            }.background(Color.scrollbackground)
                .padding(.top, -10)
                
        }


        
    }
}

#Preview {
    NavigationStack {
        GiftView(vm: GiftViewModel())
    }
}

struct CardView: View {
    let giftCard: GiftCard
    let size: Double
    @ObservedObject var vm: GiftViewModel
    var body: some View {
        Image(vm.getCardImageString(giftCard))
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            .frame(width: size)
            .shadow(radius: 5, y:4)
            .transition(.opacity)
    }
}

private struct GiftCategoryScrollView: View {
    @ObservedObject var vm: GiftViewModel
    var category: GiftCategory
    var isFeatured: Bool
    var body: some View {
        HStack(alignment:.bottom) {
            Text(isFeatured ? category.rawValue : category.rawValue.uppercased())
                .font(isFeatured ? .title : .caption)
                .bold()
                .opacity(isFeatured ? 1.0 : 0.7)
            Spacer()
            NavigationLink {
                FullPageGiftView(cards: vm.getCardsInCategory(category), label: category.rawValue, vm: vm)
            } label: {
                Text("See all \(vm.getCardsInCategory(category).count)")
                    .foregroundStyle(Color("green"))
                    .font(.title2)
                    .bold()
            }
        }.padding(.horizontal)

        ScrollView(.horizontal) {
            HStack {
                ForEach(vm.getCardsInCategory(category), id:\.image) { card in
                    CardView(giftCard: card, size: isFeatured ? 300.0 : 200, vm: vm)
                        .padding()
                }
            }
        }
    }
}
