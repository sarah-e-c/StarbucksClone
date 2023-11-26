//
//  OfferView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/19/23.
//

import SwiftUI

struct Offer2View: View {
    var body: some View {
        BaseCardView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Order at least 3 days in a row")
                        .bold()
                    Spacer()
                }.padding([.top, .leading])
                
                Text("Order a few days in a row and choose anything you'd like to get Bonus Stars.")
                    .font(.footnote)
                    .padding(.horizontal)
                Text("- Order 3 days in a row, get 100 Stars")
                    .font(.footnote)
                    .padding([.horizontal])
                    .padding(.top, 4)
                Text("- Order 5 days in a row, get 150 Stars")
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
            Image("offer2")
        }
    }
}

#Preview {
    Offer2View()
}
