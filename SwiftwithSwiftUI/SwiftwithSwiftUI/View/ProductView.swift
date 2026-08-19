//
//  ProductView.swift
//  SwiftwithSwiftUI
//
//  Created by Qubitse on 16/08/2026.
//

import SwiftUI

struct ProductView: View {
    let product: Product
    var body: some View {
        if let productIName = product.title {
            Text(productIName)
        }
    }
}
