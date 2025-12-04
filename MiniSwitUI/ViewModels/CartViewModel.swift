//
//  CartViewModel.swift
//  MiniSwitUI
//
//  Created by Lakshmi Sarath on 22/10/25.
//

import Foundation

@MainActor
class CartViewModel: ObservableObject {
    @Published var items: [Product] = []

    func addToCart(_ product: Product) {
        items.append(product)
    }

    func removeFromCart(_ product: Product) {
        items.removeAll { $0.id == product.id }
    }

    var totalPrice: Double {
        items.reduce(0) { $0 + $1.price }
    }
}
