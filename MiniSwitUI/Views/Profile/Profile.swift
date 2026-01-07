//
//  Profile.swift
//  MiniSwitUI
//
//  Created by Techversant on 04/12/25.
//

import SwiftUI

struct ProfileView: View {

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // MARK: - PROFILE HEADER
                VStack(spacing: 10) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 90, height: 90)
                        .foregroundColor(.blue)
                        .padding(.top, 20)

                    Text("Lakshmi G")
                        .font(.title2)
                        .bold()

                    Text("lakshmi@example.com")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                .padding()

                Divider()

                // MARK: - ACCOUNT SECTION
                ProfileSection(title: "My Account", items: [
                    ProfileItem(title: "My Orders", icon: "bag.fill"),
                    ProfileItem(title: "Wishlist", icon: "heart.fill"),
                    ProfileItem(title: "Saved Addresses", icon: "location.fill"),
                    ProfileItem(title: "Payment Methods", icon: "creditcard.fill")
                ])

                // MARK: - SETTINGS SECTION
                ProfileSection(title: "Settings", items: [
                    ProfileItem(title: "Notifications", icon: "bell.fill"),
                    ProfileItem(title: "Privacy Policy", icon: "lock.fill"),
                    ProfileItem(title: "Help & Support", icon: "questionmark.circle.fill")
                ])

                // MARK: - LOGOUT BUTTON
                Button(action: {
                    print("Logout tapped")  // connect with your login logic
                }) {
                    Text("Logout")
                        .foregroundColor(.red)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                Spacer().frame(height: 30)
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Profile Item Row
struct ProfileItem: Identifiable {
    var id = UUID()
    let title: String
    let icon: String
}

// MARK: - PROFILE SECTION VIEW
struct ProfileSection: View {
    let title: String
    let items: [ProfileItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text(title)
                .font(.headline)
                .padding(.horizontal)

            ForEach(items) { item in
                NavigationLink(destination: destinationView(for: item.title)) {
                    HStack {
                        Image(systemName: item.icon)
                            .foregroundColor(.blue)
                            .frame(width: 30)

                        Text(item.title)
                            .font(.body)

                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                }
            }
            
            Divider()
                .padding(.horizontal)
        }
    }

    // MARK: - Navigation Destination Logic
    @ViewBuilder
    func destinationView(for title: String) -> some View {
        switch title {
        case "My Orders":
            OrdersView()
        case "Wishlist":
            WishlistView()
        case "Saved Addresses":
            AddressListView()
        case "Payment Methods":
            PaymentMethodsView()
        case "Notifications":
            NotificationsView()
        case "Privacy Policy":
            PrivacyPolicyView()
        case "Help & Support":
            HelpSupportView()
        default:
            PlaceholderDestination(title: title)
        }
    }
}

struct PlaceholderDestination: View {
    let title: String
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "square.dashed")
                .font(.system(size: 40))
                .foregroundStyle(.secondary)
            Text("\(title) coming soon")
                .font(.headline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .navigationTitle(title)
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
}
