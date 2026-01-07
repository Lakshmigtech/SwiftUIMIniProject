//
//  Home.swift
//  MiniSwitUI
//
//  Created by Techversant on 24/12/25.
//


import SwiftUI

struct FlipkartProductRow: View {
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

                // ⭐ Rating (mocked like Flipkart)
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

                // PRICE ROW
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
        .padding(.vertical, 6)
        
    }
}


struct ProductNewListView: View {
    @EnvironmentObject var viewModel: ProductViewModel
    @EnvironmentObject var cartVM: CartViewModel

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading products...")
                        .font(.title2)

                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()

                } else {
                    List(viewModel.products) { product in
                        NavigationLink(destination: ProductDetailView(product: product)) {
                            FlipkartProductRow(product: product)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("ShopEasy 🛒")
            .task {
                await viewModel.fetchProducts()
            }
            .toolbar {
                NavigationLink(destination: CartView()) {
                    ZStack(alignment: .topTrailing) {
                        Image(systemName: "cart")
                            .font(.title3)

                        if cartVM.items.count > 0 {
                            Text("\(cartVM.items.count)")
                                .font(.caption2)
                                .foregroundColor(.white)
                                .padding(4)
                                .background(Color.red)
                                .clipShape(Circle())
                                .offset(x: 10, y: -10)
                        }
                    }
                }
            }
        }
    }
}
