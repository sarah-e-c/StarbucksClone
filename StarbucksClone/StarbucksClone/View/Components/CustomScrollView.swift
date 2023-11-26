//
//  CustomScrollView.swift
//  StarbucksClone
//
//  Created by Giuseppe Mazzilli (thank :))
//

import SwiftUI


struct CustomScrollView<Content>: View where Content: View {
    let axes: Axis.Set = .vertical
    let content: () -> Content
    let onScroll: (CGFloat) -> Void
    
    var body: some View {
        ScrollView(axes) {
            content()
                .background(
                    GeometryReader { proxy in
                        let position = (
                            axes == .vertical ?
                            proxy.frame(in: .named("scrollID")).origin.y :
                            proxy.frame(in: .named("scrollID")).origin.x
                        )
                        
                        Color.clear
                            .onChange(of: position) { position, _ in
                                onScroll(position)
                            }
                    }
                )
        }
        .coordinateSpace(.named("scrollID"))
    }
}



struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

#Preview {
    CustomScrollView {
        VStack {
            ForEach(1...100, id: \.self) {num in
                HStack {
                    Spacer()
                    Text("\(num)")
                    Spacer()
                }
                
            }
        }
    } onScroll: { position in
        print(position)
    }
}
