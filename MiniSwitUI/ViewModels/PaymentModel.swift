//
//  PaymentModel.swift
//  MiniSwitUI
//
//  Created by Techversant on 22/12/25.
//

import Foundation

enum PaymentType {
    case card
    case upi
    case applePay
    case cod

    var icon: String {
        switch self {
        case .card: return "creditcard.fill"
        case .upi: return "qrcode"
        case .applePay: return "applelogo"
        case .cod: return "banknote.fill"
        }
    }

    var title: String {
        switch self {
        case .card: return "Credit / Debit Card"
        case .upi: return "UPI"
        case .applePay: return "Apple Pay"
        case .cod: return "Cash on Delivery"
        }
    }
}

struct PaymentMethod: Identifiable {
    let id = UUID()
    let type: PaymentType
    let displayName: String
    let detail: String
    var isDefault: Bool
}
