//
//  LightGreenDivider.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/17/23.
//

import SwiftUI

struct LightGreenDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 5)
            .foregroundStyle(Color("green"))
            .opacity(0.2)
    }
}
//
#Preview {
    LightGreenDivider()
}
