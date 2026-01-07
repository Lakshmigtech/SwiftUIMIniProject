//
//  Home.swift
//  MiniSwitUI
//
//  Created by Techversant on 24/12/25.
//

import SwiftUI

struct HomeView: View {
    
    
    let product: Product

    var body: some View {
        HStack(alignment: .top, spacing: 12) {

            // PRODUCT IMAGE
            AsyncImage(url: URL(string: product.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 90, height: 120)
            .background(Color(.systemGray6))
            .cornerRadius(6)

            // PRODUCT DETAILS
            VStack(alignment: .leading, spacing: 6) {

                Text(product.title)
                    .font(.subheadline)
                    .lineLimit(2)

                // ⭐ Rating
                HStack(spacing: 4) {
                    Text("4.3 ★")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.green)
                        .cornerRadius(4)

                    Text("(2,345)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                // PRICE
                HStack(spacing: 6) {
                    Text("₹\(Int(product.price * 80))")
                        .font(.headline)
                        .bold()

                    Text("₹\(Int(product.price * 100))")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .strikethrough()

                    Text("20% off")
                        .font(.caption)
                        .foregroundColor(.green)
                }

                Text("Free Delivery")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding(8)
    }
}
struct ProductListNewView: View {
    @StateObject private var viewModel = ProductViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading products...")
                } else {
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(viewModel.products) { product in
                                NavigationLink(destination: ProductDetailNewView(product: product)) {
                                    HomeView(product: product)
                                        .background(Color.white)
                                }
                                Divider()
                            }
                        }
                    }
                }
            }
            .navigationTitle(" Style")
            .task {
                await viewModel.fetchProducts()
            }
        }
    }
}
