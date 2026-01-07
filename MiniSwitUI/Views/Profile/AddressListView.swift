//
//  AddressView.swift
//  MiniSwitUI
//
//  Created by Techversant on 08/12/25.
//

import SwiftUI

// MARK: - ADDRESS LIST VIEW
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
            type: .office
        )
    ]

    @State private var showAddAddress = false
    @State private var editingAddress: Address?
    @State private var showDeleteAlert = false
    @State private var addressToDelete: Address?

    var body: some View {
        List {
            ForEach(addresses) { address in
                AddressCard(
                    address: address,
                    onEdit: {
                        editingAddress = address
                    },
                    onDelete: {
                        addressToDelete = address
                        showDeleteAlert = true
                    }
                )
            }
            .onDelete(perform: deleteFromSwipe)
        }
        .listStyle(.plain)
        .navigationTitle("Addresses")
        .toolbar {
            Button {
                showAddAddress = true
            } label: {
                Image(systemName: "plus")
            }
        }

        // ADD ADDRESS
        .sheet(isPresented: $showAddAddress) {
            AddressEditorView { newAddress in
                addresses.append(newAddress)
            }
        }

        // EDIT ADDRESS
        .sheet(item: $editingAddress) { address in
            AddressEditorView(addressToEdit: address) { updated in
                if let index = addresses.firstIndex(where: { $0.id == updated.id }) {
                    addresses[index] = updated
                }
            }
        }

        // DELETE ALERT
        .alert("Delete Address?",
               isPresented: $showDeleteAlert,
               presenting: addressToDelete) { address in
            Button("Delete", role: .destructive) {
                deleteAddress(address)
            }
            Button("Cancel", role: .cancel) {}
        } message: { _ in
            Text("Are you sure you want to delete this address?")
        }
    }

    // MARK: - FUNCTIONS

    private func deleteAddress(_ address: Address) {
        addresses.removeAll { $0.id == address.id }
    }

    private func deleteFromSwipe(at offsets: IndexSet) {
        addresses.remove(atOffsets: offsets)
    }
}
struct AddressCard: View {

    let address: Address
    let onEdit: () -> Void
    let onDelete: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

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

            Text(address.fullAddress)

            HStack {
                Text(address.type.rawValue)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.15))
                    .clipShape(Capsule())

                Spacer()

                Button("Edit", action: onEdit)
                Button("Delete", action: onDelete)
                    .foregroundColor(.red)
            }
        }
        .padding(.vertical, 8)
    }
}
struct Address: Identifiable, Equatable {
    let id: UUID
    var name: String
    var phone: String
    var fullAddress: String
    var type: AddressType
    var isDefault: Bool

    init(
        id: UUID = UUID(),
        name: String,
        phone: String,
        fullAddress: String,
        type: AddressType,
        isDefault: Bool = false
    ) {
        self.id = id
        self.name = name
        self.phone = phone
        self.fullAddress = fullAddress
        self.type = type
        self.isDefault = isDefault
    }
}
enum AddressType: String, CaseIterable {
    case home = "Home"
    case office = "Office"
    case other = "Other"
}
struct AddressEditorView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var phone = ""
    @State private var fullAddress = ""
    @State private var type: AddressType = .home
    @State private var isDefault = false

    var addressToEdit: Address?
    let onSave: (Address) -> Void

    init(addressToEdit: Address? = nil, onSave: @escaping (Address) -> Void) {
        self.addressToEdit = addressToEdit
        self.onSave = onSave
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Phone", text: $phone)
                    .keyboardType(.numberPad)

                TextField("Full Address", text: $fullAddress)

                Picker("Type", selection: $type) {
                    ForEach(AddressType.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }

                Toggle("Set as Default", isOn: $isDefault)
            }
            .navigationTitle(addressToEdit == nil ? "Add Address" : "Edit Address")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let address = Address(
                            id: addressToEdit?.id ?? UUID(),
                            name: name,
                            phone: phone,
                            fullAddress: fullAddress,
                            type: type,
                            isDefault: isDefault
                        )
                        onSave(address)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                if let address = addressToEdit {
                    name = address.name
                    phone = address.phone
                    fullAddress = address.fullAddress
                    type = address.type
                    isDefault = address.isDefault
                }
            }
        }
    }
}

