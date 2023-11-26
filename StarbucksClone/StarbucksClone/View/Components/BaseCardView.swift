//
//  BaseCardView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/13/23.
//

import SwiftUI

struct BaseCardView<Content>: View where Content: View {
    private let bgImage: Image
    private let content: Content
    let cornerRadius: CGFloat

    public init(@ViewBuilder content: () -> Content, @ViewBuilder image: () -> Image) {
        self.bgImage = image()
        self.content = content()
        self.cornerRadius = 5.0
    }
    
    public init(cornerRadius: CGFloat, @ViewBuilder content: () -> Content, @ViewBuilder image: () -> Image) {
        self.bgImage = image()
        self.content = content()
        self.cornerRadius = cornerRadius
    }

    
    

    var body : some View {
        VStack {
            bgImage
                .resizable()
                .scaledToFit()

            content
                
        }
        
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .background(Color.white.clipShape(RoundedRectangle(cornerRadius: cornerRadius)).shadow(radius: 5))
        .background(RoundedRectangle(cornerRadius: cornerRadius)
            .strokeBorder(style: StrokeStyle())
            .opacity(0.1)
            
            )
        

        .padding()
            
        
        }
    
}

#Preview {
    BaseCardView(cornerRadius: 50) {
        Text("Hello World!")
    } image: {
        Image("offer1")
    }
}
