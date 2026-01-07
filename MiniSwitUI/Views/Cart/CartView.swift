//
//  CartView.swift
//  MiniSwitUI
//
//  Created by Lakshmi Sarath on 22/10/25.
//

import SwiftUI


struct CartView: View {
    @EnvironmentObject var cartVM: CartViewModel

    var body: some View {
        VStack(spacing: 0) {

            // MARK: - Cart List
            ScrollView {
                VStack(spacing: 12) {

                    ForEach(cartVM.items) { product in
                        CartItemCard(product: product)
                    }

                    PriceDetailsView(total: cartVM.totalPrice)
                }
                .padding(.vertical)
            }

            // MARK: - Bottom Place Order Bar
            safeBottomBar
        }
        .navigationTitle("My Cart")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var safeBottomBar: some View {
        VStack(spacing: 0) {
            Divider()

            HStack {
                VStack(alignment: .leading) {
                    Text("₹\(Int(cartVM.totalPrice * 80))")
                        .font(.headline)
                    Text("View price details")
                        .font(.caption)
                        .foregroundColor(.blue)
                }

                Spacer()

                Button("Place Order") {
                    // navigate to checkout
                }
                .frame(width: 140, height: 44)
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(4)
            }
            .padding()
            .background(Color.white)
        }
    }
}


struct CartItemCard: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            HStack(alignment: .top, spacing: 12) {

                AsyncImage(url: URL(string: product.image)) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 80, height: 80)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(6)

                VStack(alignment: .leading, spacing: 6) {
                    Text(product.title)
                        .font(.subheadline)
                        .lineLimit(2)

                    Text("₹\(Int(product.price * 80))")
                        .font(.headline)

                    Text("Free Delivery")
                        .font(.caption)
                        .foregroundColor(.green)
                }
            }

            // Quantity + Actions
            HStack {
                QuantityStepper(quantity: 1)

                Spacer()

                Button("Remove") { }
                    .foregroundColor(.gray)

                Button("Save for later") { }
                    .foregroundColor(.blue)
            }
            .font(.caption)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(6)
        .shadow(color: Color.black.opacity(0.05), radius: 2)
        .padding(.horizontal)
    }
}


struct QuantityStepper: View {
    @State var quantity: Int

    var body: some View {
        HStack(spacing: 12) {

            Button("-") {
                if quantity > 1 { quantity -= 1 }
            }
            .frame(width: 28, height: 28)
            .overlay(RoundedRectangle(cornerRadius: 4).stroke())

            Text("\(quantity)")
                .frame(width: 30)

            Button("+") {
                quantity += 1
            }
            .frame(width: 28, height: 28)
            .overlay(RoundedRectangle(cornerRadius: 4).stroke())
        }
    }
}

struct PriceDetailsView: View {
    let total: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Price Details")
                .font(.headline)

            priceRow("Price", total)
            priceRow("Delivery Charges", 0, green: true)
            Divider()
            priceRow("Total Amount", total, bold: true)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(6)
        .padding()
    }

    func priceRow(_ title: String, _ value: Double, bold: Bool = false, green: Bool = false) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(green ? "FREE" : "₹\(Int(value * 80))")
                .fontWeight(bold ? .bold : .regular)
                .foregroundColor(green ? .green : .primary)
        }
    }
}

// Removed the struct CartItem definition as per instructions

//struct CartItem: Identifiable {
//    let id = UUID()
//    let product: Product
//    var quantity: Int
//}


//struct CartView: View {
//    @EnvironmentObject var cartVM: CartViewModel
//
//    var body: some View {
//        VStack {
//            if cartVM.items.isEmpty {
//                Text("Your cart is empty 🛍️")
//                    .font(.headline)
//                    .foregroundColor(.gray)
//            } else {
//                List {
//                    ForEach(cartVM.items) { item in
//                        HStack {
//                            Text(item.title)
//                                .lineLimit(3)
//                            Spacer()
//                            Text("$\(item.price, specifier: "%.2f")")
//                        }
//                    }
//                    .onDelete { indexSet in
//                        cartVM.items.remove(atOffsets: indexSet)
//                    }
//                }
//
//                HStack {
//                    Text("Total:")
//                        .font(.headline)
//                    Spacer()
//                    Text("$\(cartVM.totalPrice, specifier: "%.2f")")
//                        .font(.headline)
//                }
//                .padding()
//
//                Button("Checkout") {
//                    print("Checkout tapped")
//                }
//                .frame(maxWidth: .infinity)
//                .padding()
//                .background(Color.green)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//                .padding()
//            }
//        }
//        .navigationTitle("Cart")
//    }
//}

