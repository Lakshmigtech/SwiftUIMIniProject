import SwiftUI

struct WishlistView: View {
    @EnvironmentObject var wishlistVM: WishlistViewModel

    var body: some View {
        NavigationStack {
            Group {
                if wishlistVM.wishlist.isEmpty {
                    ContentUnavailableView(
                        "Your Wishlist is Empty",
                        systemImage: "heart",
                        description: Text("Tap ❤️ on products to add them here")
                    )
                } else {
                    List {
                        ForEach(wishlistVM.wishlist) { item in
                            ProductRow(
                                product: item.product,
                                isWishlisted: true,
                                onWishlistTap: {
                                    wishlistVM.toggleWishlist(product: item.product)
                                }
                            )
                        }
                        .onDelete { indexSet in
                            // Using the new helper method we discussed
                            indexSet.forEach { index in
                                let product = wishlistVM.wishlist[index].product
                                wishlistVM.toggleWishlist(product: product)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Wishlist ❤️")
        }
    }

    struct ProductRow: View {
        let product: Product
        let isWishlisted: Bool
        let onWishlistTap: () -> Void

        var body: some View {
            HStack(spacing: 12) {
                // 1. Product Image
                AsyncImage(url: URL(string: product.image)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        Image(systemName: "photo") // Fallback icon
                            .foregroundColor(.gray)
                    @unknown default:
                        ProgressView()
                    }
                }
                .frame(width: 70, height: 70)
                .background(Color.secondary.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .clipped() // Prevents image from bleeding out of its 70x70 box

                // 2. Product Details
                VStack(alignment: .leading, spacing: 4) {
                    Text(product.title)
                        .font(.headline)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)

                    Text("$\(product.price, specifier: "%.2f")")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }

                Spacer()

                // 3. Wishlist Toggle Button
                Button(action: {
                    // Haptic feedback makes the app feel premium
                    let impact = UIImpactFeedbackGenerator(style: .medium)
                    impact.impactOccurred()
                    
                    onWishlistTap()
                }) {
                    Image(systemName: isWishlisted ? "heart.fill" : "heart")
                        .font(.title3)
                        .foregroundColor(isWishlisted ? .red : .gray)
                        .contentTransition(.symbolEffect(.replace)) // Animated icon swap
                }
                .buttonStyle(.plain) // Prevents the whole row from highlighting when tapped
            }
            .padding(.vertical, 8)
        }
    }
}

// MARK: - Preview Fix
// This prevents the "Fatal Error" inside Xcode's Preview Canvas
#Preview {
    WishlistView()
        .environmentObject(WishlistViewModel())
}
