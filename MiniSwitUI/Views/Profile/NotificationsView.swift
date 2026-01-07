//
//  NotificationView.swift
//  MiniSwitUI
//
//  Created by Techversant on 22/12/25.
//


import SwiftUI

struct NotificationRow: View {
    let notification: AppNotification

    var body: some View {
        HStack(alignment: .top, spacing: 12) {

            Image(systemName: notification.type.icon)
                .foregroundColor(notification.type.color)
                .font(.title3)
                .padding(8)
                .background(notification.type.color.opacity(0.1))
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 4) {
                Text(notification.title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(notification.message)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)

                Text(notification.time)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            if !notification.isRead {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 8, height: 8)
            }
        }
        .padding(.vertical, 8)
    }
}



struct NotificationsView: View {

    @State private var notifications: [AppNotification] = [
        AppNotification(
            title: "Order Shipped",
            message: "Your order #12345 is on the way",
            time: "2 hours ago",
            type: .order,
            isRead: false
        ),
        AppNotification(
            title: "Flat 40% OFF",
            message: "Mega sale ends tonight!",
            time: "Yesterday",
            type: .offer,
            isRead: true
        ),
        AppNotification(
            title: "Price Drop Alert",
            message: "Nike shoes now ₹3,999",
            time: "2 days ago",
            type: .wishlist,
            isRead: true
        )
    ]

    var body: some View {
        List {
            ForEach(notifications) { notification in
                NotificationRow(notification: notification)
                    .swipeActions {
                        Button(role: .destructive) {
                            delete(notification)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Notifications")
    }

    private func delete(_ notification: AppNotification) {
        notifications.removeAll { $0.id == notification.id }
    }
}
