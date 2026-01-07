//
//  Payment.swift
//  MiniSwitUI
//
//  Created by Techversant on 22/12/25.
//

import SwiftUI

struct PaymentMethodsView: View {

    @State private var methods: [PaymentMethod] = [
        PaymentMethod(
            type: .card,
            displayName: "Visa Card",
            detail: "**** 4589",
            isDefault: true
        ),
        PaymentMethod(
            type: .upi,
            displayName: "Google Pay",
            detail: "lakshmi@upi",
            isDefault: false
        ),
        PaymentMethod(
            type: .cod,
            displayName: "Cash on Delivery",
            detail: "Pay at your doorstep",
            isDefault: false
        )
    ]

    var body: some View {
        List {
            Section {
                ForEach(methods) { method in
                    PaymentMethodRow(method: method)
                }
                .onDelete(perform: delete)
            }

            Section {
                NavigationLink {
                    AddPaymentMethodView()
                } label: {
                    Label("Add Payment Method", systemImage: "plus.circle.fill")
                        .foregroundColor(.blue)
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Payment Methods")
    }

    private func delete(at offsets: IndexSet) {
        methods.remove(atOffsets: offsets)
    }
}


struct PaymentMethodRow: View {
    let method: PaymentMethod

    var body: some View {
        HStack(spacing: 14) {

            Image(systemName: method.type.icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 40)

            VStack(alignment: .leading, spacing: 4) {
                Text(method.displayName)
                    .font(.headline)

                Text(method.detail)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            if method.isDefault {
                Text("Default")
                    .font(.caption2)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.green.opacity(0.15))
                    .foregroundColor(.green)
                    .cornerRadius(8)
            }
        }
        .padding(.vertical, 8)
    }
}
struct AddPaymentMethodView: View {

    @State private var cardNumber = ""
    @State private var expiry = ""
    @State private var cvv = ""

    var body: some View {
        Form {
            Section(header: Text("Card Details")) {
                TextField("Card Number", text: $cardNumber)
                    .keyboardType(.numberPad)

                TextField("Expiry (MM/YY)", text: $expiry)

                SecureField("CVV", text: $cvv)
            }

            Button("Save Card") {
                // Save logic (tokenize via payment gateway)
            }
            .frame(maxWidth: .infinity)
        }
        .navigationTitle("Add Card")
    }
}
