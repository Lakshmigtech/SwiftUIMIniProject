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
        VStack(spacing: 0) {

            // MARK: - CONTENT
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {

                    // Image Carousel
                    ProductImageCarousel(image: product.image)

                    // Title
                    Text(product.title)
                        .font(.headline)
                        .padding(.horizontal)

                    // Rating
                    RatingBadge(rating: 4.4)
                        .padding(.horizontal)

                    // Price Section
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("₹\(Int(product.price * 80))")
                                .font(.title2)
                                .fontWeight(.bold)

                            Text("₹\(Int(product.price * 100))")
                                .font(.subheadline)
                                .strikethrough()
                                .foregroundColor(.gray)

                            Text("20% OFF")
                                .font(.caption)
                                .foregroundColor(.green)
                        }

                        Text("Free Delivery")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                    .padding(.horizontal)

                    Divider()

                    // Offers
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Available Offers")
                            .font(.headline)

                        Label("10% Instant Discount on ICICI Cards", systemImage: "tag.fill")
                        Label("Buy 2 Get Extra 5% Off", systemImage: "tag.fill")
                    }
                    .font(.subheadline)
                    .padding(.horizontal)

                    Divider()

                    // Description
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Product Details")
                            .font(.headline)

                        Text(product.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                }
            }

            // MARK: - BOTTOM BAR (Flipkart Style)
            .safeAreaInset(edge: .bottom) {
                HStack(spacing: 0) {

                    // Add to Cart
                    Button {
                        cartVM.addToCart(product)
                        withAnimation {
                            addedToCart = true
                        }
                    } label: {
                        Text(addedToCart ? "Added ✓" : "Add to Cart")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(.blue)
                    }

                    // Buy Now
                    Button {
                        cartVM.addToCart(product)
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(Color.orange)     // 👈 orange ONLY here

                            Text("Buy Now")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                    }
                }
                .frame(height: 56)
                .background(Color.white)        // 👈 bottom area stays white
                .overlay(Divider(), alignment: .top)
            }

        }
        .navigationTitle("Product")
        .navigationBarTitleDisplayMode(.inline)
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


struct RatingBadge: View {
    let rating: Double

    var body: some View {
        HStack(spacing: 4) {
            Text(String(format: "%.1f ★", rating))
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(6)

            Text("1,234 Ratings")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

struct ProductImageCarousel: View {
    let image: String

    var body: some View {
        TabView {
            AsyncImage(url: URL(string: image)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
        }
        .frame(height: 280)
        .tabViewStyle(.page)
        .background(Color.white)
    }
}



