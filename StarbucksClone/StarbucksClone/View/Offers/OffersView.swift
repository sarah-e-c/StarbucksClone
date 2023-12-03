//
//  OffersView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/19/23.
//

import SwiftUI

struct OffersView: View {
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Offers")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    Spacer()
                }
                HeaderEdgeDivider()
            }.background(Color.white)

            ScrollView {
                VStack {
                    Offer1View()
                        .padding(.bottom, -30)
                    Offer2View()
                }
            }.padding(.top, -10)

        }.background(Color.scrollbackground)

    }
}

#Preview {
    OffersView()
}
