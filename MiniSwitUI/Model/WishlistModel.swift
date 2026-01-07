//
//  WishlistModel.swift
//  MiniSwitUI
//
//  Created by Techversant on 17/12/25.
//

import SwiftUI

struct WishlistModel: Codable, Identifiable {
    let id: Int
    let product: Product
    var isWishlisted: Bool
}
