//
//  GreenButton.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/18/23.
//

import SwiftUI

struct GreenButton: View {
    // listen to this
    @ObservedObject var cartservice = CartService.shared
    @ObservedObject var favoriteservice = FavoriteService.shared
    let text: String
    let font: Font
    init(_ text: String) {
        self.text = text
        self.font = .title3
    }
    
    init(_ text: String, font: Font) {
        self.text = text
        self.font = font
    }
    
    var body: some View {
        Text(text)
            .font(.title3)
            .bold()
            .foregroundStyle(.white)
            .padding()
            .padding(.horizontal)
            .background(RoundedRectangle(cornerRadius: 50.0).foregroundStyle(Color("green")))
            .padding()
            .shadow(radius: 10, x:0, y: 10)
            .offset(CGSize(width: 0.0, height: cartservice.cartRecentlyChanged || favoriteservice.messageAvailable ? -40.0 : 0.0))
    }
}

#Preview {
    GreenButton("hi", font:.body)
}
