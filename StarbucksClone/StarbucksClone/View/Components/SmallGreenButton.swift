//
//  SmallGreenButton.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/18/23.
//

import SwiftUI

struct SmallGreenButton: View {
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
            .bold()
            .foregroundStyle(.white)
            .padding(4)
            .padding(.horizontal, 10)
            .background(RoundedRectangle(cornerRadius: 50.0).foregroundStyle(Color("green")))
    }
}

#Preview {
    SmallGreenButton("Hello!")
}
