//
//  ProductListView.swift
//  MiniSwitUI
//
//  Created by Lakshmi Sarath on 22/10/25.
//

import SwiftUI

struct ProductListView: View {
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
                            HStack(spacing: 12) {
                                
                                AsyncImage(url: URL(string: product.image)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 60, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 8))

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(product.title)
                                        .font(.headline)
                                        .lineLimit(2)

                                    Text("$\(product.price, specifier: "%.2f")")
                                        .foregroundColor(.blue)
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
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

