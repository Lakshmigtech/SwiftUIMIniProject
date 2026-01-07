import Foundation

@MainActor
class WishlistViewModel: ObservableObject {

    @Published var wishlist: [WishlistModel] = []
    
    // Constant key to prevent typos
    private let storageKey = "wishlist_items"

    init() {
        loadWishlist()
    }

    // MARK: - User Intents

    func toggleWishlist(product: Product) {
        if let index = wishlist.firstIndex(where: { $0.id == product.id }) {
            // Remove if exists
            wishlist.remove(at: index)
        } else {
            // Add if not exists
            let newItem = WishlistModel(
                id: product.id,
                product: product,
                isWishlisted: true
            )
            wishlist.append(newItem)
        }
        
        // Explicitly save after modifying the array
        saveWishlist()
    }
    
    // Optional: Helper function if you implement swipe-to-delete in the UI
    func removeWishlist(at offsets: IndexSet) {
        wishlist.remove(atOffsets: offsets)
        saveWishlist()
    }

    func isWishlisted(productId: Int) -> Bool {
        return wishlist.contains { $0.id == productId }
    }

    // MARK: - Persistence

    private func saveWishlist() {
        // Run encoding in a generic implementation to catch errors
        do {
            let data = try JSONEncoder().encode(wishlist)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            print("❌ Error saving wishlist: \(error.localizedDescription)")
        }
    }

    private func loadWishlist() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else { return }
        
        do {
            wishlist = try JSONDecoder().decode([WishlistModel].self, from: data)
        } catch {
            print("❌ Error loading wishlist (Data version mismatch?): \(error.localizedDescription)")
            // If decoding fails (e.g., you changed the model), clear the old corrupt data
            // UserDefaults.standard.removeObject(forKey: storageKey)
            // wishlist = []
        }
    }
}
