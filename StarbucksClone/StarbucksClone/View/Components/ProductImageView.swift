//
//  ProductImage.swift
//  StarbucksClone
//
//  Created by Sarah Crowder on 11/17/23.
//

import SwiftUI

struct ProductImageView: View {
    let product: Product
    let size: Constants.IconSizes
    var needsZooming: Bool {
        return (product.productBigCategory == ProductBigCategory.drinks)
    }
    var body: some View {
        Image(product.productName)
            .resizable()
            .scaleEffect(needsZooming ? CGSize(width: 1.75, height: 1.75) : CGSize(width: 1.0, height: 1.0))
            .offset(needsZooming ? CGSize(width: 0, height: size.rawValue / 4): CGSize())
            .scaledToFit()
            .clipShape(Circle())
            .frame(width: size.rawValue)
    }
}

#Preview {
    ProductImageView(product: Product.example, size: .scrollSize)
}
