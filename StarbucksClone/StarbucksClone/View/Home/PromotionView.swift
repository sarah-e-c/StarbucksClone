//
//  PromotionView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/23/23.
//

import SwiftUI

struct PromotionView: View {
    let image: String
    let titleLabel: String
    let bodyText: String
    let buttonText: String
    var body: some View {
        BaseCardView {
            VStack(alignment: .leading) {
                HStack {
                    Text(titleLabel)
                        .bold()
                        .padding(.bottom, 5)
                    Spacer()
                }
                Text(bodyText)
                    .font(.caption)
                    .padding(.bottom, 5)
                    
                SmallGreenButton(buttonText)
                    
            }.padding()

        } image: {
            Image(image)
        }
    }
}

#Preview {
    PromotionView(image: "promotion1", titleLabel: "Hello", bodyText: "Celebrate with a Chestnut Praline Latte, sprinkled with spiced praline crumbs.", buttonText: "Create")
}
