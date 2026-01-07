//
//  AddaddressView.swift
//  MiniSwitUI
//
//  Created by Techversant on 08/12/25.
//

import SwiftUI

struct AddAddressView: View {
    
    @Environment(\.dismiss) var dismiss   // to close screen after saving
    
    @State private var name = ""
    @State private var phone = ""
    @State private var house = ""
    @State private var street = ""
    @State private var city = ""
    @State private var state = ""
    @State private var pincode = ""
    @State private var addressType: AddressType = .home
    
    var onSave: (Address) -> Void
    
    var body: some View {
        Form {
            Section(header: Text("Contact Details")) {
                TextField("Full Name", text: $name)
                TextField("Phone Number", text: $phone)
                    .keyboardType(.phonePad)
            }
            
            Section(header: Text("Address Details")) {
                TextField("House / Flat No.", text: $house)
                TextField("Street / Locality", text: $street)
                TextField("City", text: $city)
                TextField("State", text: $state)
                TextField("Pincode", text: $pincode)
                    .keyboardType(.numberPad)
            }
            
            Section(header: Text("Address Type")) {
                Picker("Type", selection: $addressType) {
                    Text("Home").tag(AddressType.home)
                    Text("Office").tag(AddressType.office)
                    Text("Other").tag(AddressType.other)
                }
                .pickerStyle(.segmented)
            }
            
            Section {
                Button(action: saveAddress) {
                    Text("Save Address")
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .navigationTitle("Add New Address")
    }
    
    func saveAddress() {
        // Create new full address string
        let fullAddress = "\(house), \(street), \(city), \(state) - \(pincode)"
        
        let newAddress = Address(
            name: name,
            phone: phone,
            fullAddress: fullAddress,
            type: addressType,
            isDefault: false
        )
        
        onSave(newAddress)
        dismiss()   // close view
    }
}


