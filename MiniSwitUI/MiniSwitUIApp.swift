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

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(cartVM)
                .environmentObject(productVM)
                .environmentObject(authVM)
        }
    }
}


