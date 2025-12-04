//
//  MainTabView.swift
//  MiniSwitUI
//
//  Created by Techversant on 04/12/25.
//


import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {

            NavigationStack {
                ProductListView()
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }

            NavigationStack {
                CartView()
            }
            .tabItem {
                Label("Cart", systemImage: "cart")
            }

            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Label("Profile", systemImage: "person")
            }
        } .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
