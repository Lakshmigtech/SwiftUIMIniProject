//
//  CategoryModel.swift
//  MiniSwitUI
//
//  Created by Techversant on 06/01/26.
//

import Foundation
import SwiftUI


enum CategoryType: CaseIterable, Identifiable {
    case mobiles
    case fashion
    case electronics
    case home
    case beauty

    var id: Self { self }
}

struct Category: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let type: CategoryType
}

extension CategoryType {
    var apiCategory: String {
        switch self {
        case .mobiles:
            return "electronics"
        case .fashion:
            // If your API needs a single category string, pick one. Adjust as needed.
            return "men's clothing"
        case .electronics:
            return "electronics"
        case .home:
            return "electronics"
        case .beauty:
            return "jewelery"
        }
    }

    var title: String {
        switch self {
        case .mobiles: return "Mobiles"
        case .fashion: return "Fashion"
        case .electronics: return "Electronics"
        case .home: return "Home"
        case .beauty: return "Beauty"
        }
    }
}
