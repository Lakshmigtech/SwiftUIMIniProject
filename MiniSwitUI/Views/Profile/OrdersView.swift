//
//  OrdersView.swift
//  MiniSwitUI
//
//  Created by Techversant on 08/12/25.
//

import SwiftUI

struct OrdersView: View {
    
    // Temporary sample data
    let orders: [Order] = [
        Order(id: "ORD12345", productName: "Wireless Bluetooth Headphones", image: "headphones", price: 2999, status: .delivered, date: "28 Nov 2025"),
        Order(id: "ORD98765", productName: "Apple Watch Strap", image: "applewatch", price: 999, status: .pending, date: "30 Nov 2025"),
        Order(id: "ORD56789", productName: "iPhone 14 Soft Case", image: "iphone", price: 499, status: .cancelled, date: "25 Nov 2025")
    ]
    
    var body: some View {
        List(orders) { order in
            OrderCard(order: order)
        }
        .listStyle(.plain)
        .navigationTitle("My Orders")
    }
}
struct OrderCard: View {
    let order: Order
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HStack {
                Image(systemName: "shippingbox.fill")
                    .foregroundColor(.blue)
                Text("Order ID: \(order.id)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            HStack(spacing: 12) {
                
                Image(order.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(order.productName)
                        .font(.body)
                        .foregroundStyle(.primary)
                        .lineLimit(2)
                    
                    Text("₹\(order.price)")
                        .font(.headline)
                        .foregroundColor(.blue)
                    
                    Text("Ordered on \(order.date)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            HStack {
                Spacer()
                StatusBadge(status: order.status)
            }
        }
        .padding(.vertical, 10)
    }
}
struct Order: Identifiable {
    let id: String
    let productName: String
    let image: String
    let price: Double
    let status: OrderStatus
    let date: String
}

enum OrderStatus {
    case delivered, pending, cancelled
}
struct StatusBadge: View {
    let status: OrderStatus
    
    var body: some View {
        Text(statusText)
            .font(.caption)
            .fontWeight(.bold)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .foregroundColor(.white)
            .background(statusColor)
            .clipShape(Capsule())
    }
    
    private var statusText: String {
        switch status {
        case .delivered: return "Delivered"
        case .pending: return "Pending"
        case .cancelled: return "Cancelled"
        }
    }
    
    private var statusColor: Color {
        switch status {
        case .delivered: return .green
        case .pending: return .orange
        case .cancelled: return .red
        }
    }
}
