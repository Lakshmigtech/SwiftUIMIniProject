//
//  ProductDetailView.swift
//  MiniSwitUI
//
//  Created by Lakshmi Sarath on 22/10/25.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @EnvironmentObject var cartVM: CartViewModel
    @State private var addedToCart = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: product.image)) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 250)

                Text(product.title)
                    .font(.title2)
                    .multilineTextAlignment(.center)

                Text("$\(product.price, specifier: "%.2f")")
                    .font(.title3)
                    .foregroundColor(.green)
              
              Text(product.description)
                                  .font(.body)
                                  .foregroundColor(.secondary)

                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                        addedToCart.toggle()
                        cartVM.addToCart(product)
                    }

                    // Reset animation after short delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation {
                            addedToCart = false
                        }
                    }

                }) {
                    HStack {
                        Image(systemName: addedToCart ? "checkmark.circle.fill" : "cart.badge.plus")
                        Text(addedToCart ? "Added!" : "Add to Cart")
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(addedToCart ? Color.green : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .scaleEffect(addedToCart ? 1.15 : 1.0)
                    .shadow(radius: addedToCart ? 8 : 4)
                }
                .padding(.top, 10)
            }
            .padding()
            .toolbar {
              NavigationLink(destination: CartView()) {
                  HStack {
                      Image(systemName: "cart")
                     Text("\(cartVM.items.count)")
                  }
              }
          }
        }
    }
}

