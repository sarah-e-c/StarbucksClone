//
//  FullPageGiftView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/21/23.
//

import SwiftUI

struct FullPageGiftView: View {
    let cards: [GiftCard]
    let label: String
    @ObservedObject var vm: GiftViewModel
    var body: some View {
        VStack {
            HStack {
                Text(label)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                Spacer()
            }
            HeaderEdgeDivider()
                

            ScrollView {
                ForEach(cards, id:\.image) { card in
                    CardView(giftCard: card, size: 350, vm: vm)
                        .padding()
                        
                }
            }.padding(.top, -8)
        }.background(Color.scrollbackground)
    }
}

#Preview {
    FullPageGiftView(cards: [GiftCard.example], label: "Example", vm:GiftViewModel())
}
