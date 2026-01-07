//
//  Notifications.swift
//  MiniSwitUI
//
//  Created by Techversant on 22/12/25.
//

import Foundation
import SwiftUI

enum NotificationType {
    case order
    case offer
    case wishlist
    case payment

    var icon: String {
        switch self {
        case .order: return "shippingbox.fill"
        case .offer: return "tag.fill"
        case .wishlist: return "heart.fill"
        case .payment: return "creditcard.fill"
        }
    }

    var color: Color {
        switch self {
        case .order: return .blue
        case .offer: return .orange
        case .wishlist: return .pink
        case .payment: return .green
        }
    }
}

struct AppNotification: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let time: String
    let type: NotificationType
    var isRead: Bool
}
