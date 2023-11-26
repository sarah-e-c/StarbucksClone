//
//  ProductIconView.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/16/23.
//

import SwiftUI

struct ProductIconView: View {
    var product: Product

    var size: Constants.IconSizes
    
    var body: some View {
        VStack {
            ProductImageView(product: product, size: size)
                
            Text(product.productName)
                .font(.caption2)
                .bold()
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .frame(height: size.rawValue / 4)
            
        }.frame(width: size.rawValue)
            
    }
}

#Preview {
    ProductIconView(product: Product.example, size: .scrollSize)
}

