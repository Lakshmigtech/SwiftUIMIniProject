//
//  AddressView.swift
//  MiniSwitUI
//
//  Created by Techversant on 08/12/25.
//

import SwiftUI

struct AddressListView: View {
    @State private var addresses: [Address] = [
        Address(
            name: "Lakshmi G",
            phone: "9876543210",
            fullAddress: "House No. 12, ABC Nagar, Kochi, Kerala - 682001",
            type: .home,
            isDefault: true
        ),
        Address(
            name: "Sarath Kumar",
            phone: "9123456780",
            fullAddress: "Tech Park, 3rd Floor, Kakkanad, Kochi",
            type: .office,
            isDefault: false
        )
    ]

    var body: some View {
        VStack {
            List {
                ForEach(addresses) { address in
                    AddressCard(address: address)
                }
                .onDelete(perform: deleteAddress)
            }
            .listStyle(.plain)

            // ADD NEW ADDRESS BUTTON
            Button(action: {
                print("Add new address tapped")
            }) {
                Text("Add New Address")
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .navigationTitle("Addresses")
    }

    private func deleteAddress(at offsets: IndexSet) {
        addresses.remove(atOffsets: offsets)
    }
}

struct AddressCard: View {
    let address: Address

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // NAME + PHONE
            HStack {
                Text(address.name)
                    .font(.headline)

                Spacer()

                if address.isDefault {
                    Text("Default")
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.green.opacity(0.2))
                        .foregroundColor(.green)
                        .clipShape(Capsule())
                }
            }

            Text(address.phone)
                .foregroundColor(.gray)
                .font(.subheadline)

            // FULL ADDRESS
            Text(address.fullAddress)
                .font(.body)
                .foregroundColor(.primary)
                .lineLimit(3)

            // TAG + EDIT BUTTONS
            HStack {
                Text(address.type.rawValue)
                    .font(.caption)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(Color.blue.opacity(0.15))
                    .foregroundColor(.blue)
                    .clipShape(Capsule())

                Spacer()

                Button("Edit") {
                    print("Edit address tapped!")
                }
                .foregroundColor(.blue)

                Button("Delete") {
                    print("Delete action")
                }
                .foregroundColor(.red)
            }
        }
        .padding(.vertical, 8)
    }
}

struct Address: Identifiable {
    let id = UUID()
    let name: String
    let phone: String
    let fullAddress: String
    let type: AddressType
    let isDefault: Bool
}

enum AddressType: String {
    case home = "Home"
    case office = "Office"
    case other = "Other"
}

#Preview {
    NavigationView {
        AddressListView()
    }
}
