//
//  NotificationView.swift
//  MiniSwitUI
//
//  Created by Techversant on 22/12/25.
//

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
