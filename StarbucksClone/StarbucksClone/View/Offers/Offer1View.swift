//
//  OfferView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/19/23.
//

import SwiftUI

struct Offer1View: View {
    var body: some View {
        BaseCardView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Order this for stars")
                        .bold()
                    Spacer()
                }.padding([.top, .leading])
                Text("Order any latte just one time and collect 10 Bonus Stars.")
                    .font(.footnote)
                    .padding(.horizontal)
                HStack {
                    Button {

                    } label: {
                        SmallGreenButton("Start")
                            .padding()
                    }

                    Spacer()
                    Text("Terms")
                        .foregroundStyle(Color("green"))
                        .padding()
                }
                
            }
        } image: {
            Image("offer1")
        }
    }
}

#Preview {
    Offer1View()
}
