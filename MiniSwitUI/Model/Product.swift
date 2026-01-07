//
//  Product.swift
//  MiniSwitUI
//
//  Created by Lakshmi Sarath on 22/10/25.
//

import Foundation

struct Product: Identifiable, Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let image: String
    let category: String
}
struct Rating: Codable {
    let count: Int
    let rate: Double
}
