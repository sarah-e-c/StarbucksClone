//
//  MessageView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/25/23.
//

import SwiftUI

struct MessageView: View {
    @ObservedObject var vm: StoreAndCartViewModel
    @ObservedObject private var service = CartService.shared
    @ObservedObject private var favservice = FavoriteService.shared
    
    var body: some View {
        Group {
            if vm.message != nil {
                HStack {
                    Text(vm.message ?? "")
                        .font(.caption)
                        .padding()
                        .padding(.trailing)
                    Spacer()
                }
                
                .frame(height:50)
                .foregroundStyle(.white)
                
                .background(Color("green"))
                
            }
        }.padding(.bottom, -8)
    }
}

#Preview {
    MessageView(vm: StoreAndCartViewModel())
}
