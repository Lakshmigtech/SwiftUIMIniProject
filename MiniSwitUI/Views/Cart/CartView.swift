//
//  CartView.swift
//  MiniSwitUI
//
//  Created by Lakshmi Sarath on 22/10/25.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartVM: CartViewModel

    var body: some View {
        VStack {
            if cartVM.items.isEmpty {
                Text("Your cart is empty 🛍️")
                    .font(.headline)
                    .foregroundColor(.gray)
            } else {
                List {
                    ForEach(cartVM.items) { item in
                        HStack {
                            Text(item.title)
                                .lineLimit(3)
                            Spacer()
                            Text("$\(item.price, specifier: "%.2f")")
                        }
                    }
                    .onDelete { indexSet in
                        cartVM.items.remove(atOffsets: indexSet)
                    }
                }

                HStack {
                    Text("Total:")
                        .font(.headline)
                    Spacer()
                    Text("$\(cartVM.totalPrice, specifier: "%.2f")")
                        .font(.headline)
                }
                .padding()

                Button("Checkout") {
                    print("Checkout tapped")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
            }
        }
        .navigationTitle("Cart")
    }
}
