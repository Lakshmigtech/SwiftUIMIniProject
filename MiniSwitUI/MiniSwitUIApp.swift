//
//  MiniSwitUIApp.swift
//  MiniSwitUI
//
//  Created by Lakshmi Sarath on 21/10/25.
//

import SwiftUI

@main
struct MiniSwitUIApp: App {
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground

        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().standardAppearance = appearance
    }
    @StateObject var cartVM = CartViewModel()
    @StateObject var productVM = ProductViewModel()
    @StateObject var authVM = AuthViewModel()
    @StateObject private var wishlistVM = WishlistViewModel()

    var body: some Scene {
        WindowGroup {
            if authVM.isLoggedIn {
                MainTabView()
                    .environmentObject(cartVM)
                    .environmentObject(productVM)
                    .environmentObject(authVM)
                    .environmentObject(wishlistVM)
            } else {
                LoginView()
                    .environmentObject(cartVM)
                    .environmentObject(productVM)
                    .environmentObject(authVM)
            }
        }
    }
}

#Preview {
    WishlistView()
        .environmentObject(WishlistViewModel()) // Inject a fresh instance for the preview
}
