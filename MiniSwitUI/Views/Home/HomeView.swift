//
//  Home.swift
//  MiniSwitUI
//
//  Created by Techversant on 24/12/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var productVM: ProductViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {

                    // 🔍 Search Bar
                    FlipkartSearchBar()

                    // 📦 Categories
                    CategorySection()

                    // 🖼️ Banner Carousel
                    BannerCarousel()

                    // 🔥 Deals
                    DealsSection()

                    // 🛍️ Products
                    VStack(alignment: .leading) {
                        Text("Recommended for You")
                            .font(.headline)
                            .padding(.horizontal)

                        ForEach(productVM.products.prefix(6)) { product in
                            NavigationLink {
                                ProductDetailView(product: product)
                            } label: {
                                FlipkartProductRow(product: product)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Flipkart")
            .task {
                await productVM.fetchProducts()
            }
        }
    }
}
struct FlipkartSearchBar: View {
    @State private var searchText = ""

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search for products, brands and more", text: $searchText)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .padding(.horizontal)
    }
}
    struct CategorySection: View {

        let categories: [Category] = [
            Category(title: "Mobiles", icon: "mobiles", type: .mobiles),
            Category(title: "Fashion", icon: "fashion", type: .fashion),
            Category(title: "Electronics", icon: "electronics", type: .electronics),
            Category(title: "Home", icon: "home", type: .home),
            Category(title: "Beauty", icon: "beauty", type: .beauty)
        ]

        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 18) {
                    ForEach(categories) { category in
                        NavigationLink {
                            CategoryDestinationView(type: category.type)
                        } label: {
                            VStack(spacing: 6) {

                                Circle()
                                    .fill(Color.blue.opacity(0.15))
                                    .frame(width: 56, height: 56)
                                    .overlay(
                                        Image(category.icon)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 28, height: 28)
                                    )

                                Text(category.title)
                                    .font(.caption)
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 72)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 6)
            }
        }
    }

struct CategoryDestinationView: View {

    let type: CategoryType
    @StateObject private var productVM = ProductViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {

            if productVM.isLoading {
                ProgressView("Loading \(type.title)...")
                    .padding(.top, 40)

            } else if let error = productVM.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding()

            } else {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(productVM.products) { product in
                        NavigationLink {
                            ProductDetailView(product: product)
                        } label: {
                            FlipkartProductCard(product: product)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle(type.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .navigationBar)
        .task {
            await productVM.fetchProductsByCategory(type.apiCategory)
        }
    }
}
struct BannerCarousel: View {
    let banners = ["offer1", "offer2", "offer3"] // add assets

    var body: some View {
        TabView {
            ForEach(banners, id: \.self) { banner in
                Image(banner)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 160)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
        }
        .frame(height: 160)
        .tabViewStyle(.page)
    }
}
struct DealsSection: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Deals of the Day 🔥")
                .font(.headline)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(1..<6) { _ in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.orange.opacity(0.8))
                            .frame(width: 140, height: 80)
                            .overlay(
                                Text("Up to 60% OFF")
                                    .foregroundColor(.white)
                                    .bold()
                            )
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct FlipkartProductCard: View {

    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            // Product Image
            AsyncImage(url: URL(string: product.image)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure(_):
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                default:
                    ProgressView()
                }
            }
            .frame(height: 120)
            .frame(maxWidth: .infinity)
            .background(Color(.systemGray6))
            .cornerRadius(8)

            // Product Title
            Text(product.title)
                .font(.caption)
                .lineLimit(2)

            // Price
            Text("₹\(Int(product.price * 80))")
                .font(.headline)
                .foregroundColor(.blue)
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.08), radius: 4)
    }
}

