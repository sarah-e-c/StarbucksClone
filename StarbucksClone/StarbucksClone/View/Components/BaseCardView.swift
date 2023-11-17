//
//  BaseCardView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/13/23.
//

import SwiftUI

struct BaseCardView<Content>: View where Content: View {
    private let bgImage = Image.init(systemName: "m.circle.fill")
    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body : some View {
        VStack {
            bgImage
                .resizable()
                .scaledToFit()
                .opacity(0.2)
                .frame(height: 80)
            content
        }.padding()
        
        }
    
}

#Preview {
    BaseCardView {
        Text("Hello World!")
    }
}
