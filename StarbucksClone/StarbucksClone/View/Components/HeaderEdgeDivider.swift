//
//  HeaderEdgeDivider.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/22/23.
//

import SwiftUI

struct HeaderEdgeDivider: View {
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 1)
                .opacity(0.2)
                .offset(y:-1)
                .shadow(radius: 10)
                .offset(y:-2)
                
            Rectangle()
                .frame(height: 2)
                .opacity(0.1)
                .offset(y:-2)

        }

        
    }
}

#Preview {
    VStack {
        Text("Hello, World!")
            .font(.title)
        HeaderEdgeDivider()
        Spacer()
            .background(Color.scrollbackground)
    }
   
}
