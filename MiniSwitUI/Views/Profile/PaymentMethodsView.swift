//
//  Payment.swift
//  MiniSwitUI
//
//  Created by Techversant on 22/12/25.
//

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
