//
//  TopTabView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/19/23.
//

import SwiftUI

struct TopTabView: View {
    @State private var selectedIndex = 0
    
    let labels: [String]
    let views: [AnyView]
    
    
    init(labels: [String], views: [any View]) {
        self.views = views.map({AnyView($0)})
        self.labels = labels
    }
    

    var body: some View {
        VStack {
            VStack {
                VStack {
                    HStack {
                        ForEach(0...labels.count - 1, id:\.self) { index in
                            Button {
                                withAnimation {
                                    selectedIndex = index
                                }
                                
                            } label: {
                                TabItemView(selectedIndex: $selectedIndex, index: index, label: labels[index])
                            }
                        }
                        Spacer()
                    }
                    HStack {
                        Rectangle()
                            .foregroundStyle(Color.lightgreen)
                            .frame(width: UIScreen.screenWidth / CGFloat(labels.count), height: 3)
                            .padding(.top, -10)
                            .offset(x: UIScreen.screenWidth / CGFloat(labels.count) * CGFloat(selectedIndex))
                        Spacer()
                    }

                        
                }
                HeaderEdgeDivider()
                    .padding(.top, -13)
            }
            .padding(.bottom, -16)
            views[selectedIndex]
                .padding(.top, -6)
            Spacer()
        }.onAppear(perform: {
            guard labels.count > 1 else {return}
            selectedIndex = 1
            selectedIndex = 0
        })
        
    }
}


private struct TabItemView: View {
    @Binding var selectedIndex: Int
    let index: Int
    let label: String
    var body: some View {
        VStack {
            Text(label)
                .foregroundStyle(.black)
                .bold()
                .opacity(selectedIndex == index ? 1.0 : 0.7)
            ZStack {
                Rectangle()
                    .foregroundStyle(Color.lightgreen)
                    .frame(height: 2)
                    .opacity(0.0)
            }

        }

        
            
    }
}

#Preview {
    TopTabView(labels: ["hello", "ur mom"], views: [Text("hello!"), Text("Ur mom is helpful")])
}
