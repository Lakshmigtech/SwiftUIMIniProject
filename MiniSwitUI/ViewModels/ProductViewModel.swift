//
//  ProductViewModel.swift
//  MiniSwitUI
//
//  Created by Lakshmi Sarath on 22/10/25.
//

import Foundation

//@MainActor
//class ProductViewModel: ObservableObject {
//    @Published var products: [Product] = []
//    @Published var isLoading = false
//    @Published var errorMessage: String?
//
//    func fetchProducts() async {
//        isLoading = true
//        defer { isLoading = false }
//
//        guard let url = URL(string: "https://fakestoreapi.com/products") else { return }
//
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//            let decoded = try JSONDecoder().decode([Product].self, from: data)
//            self.products = decoded
//        } catch {
//            self.errorMessage = "Failed to load products: \(error.localizedDescription)"
//        }
//    }
//}


@MainActor
class ProductViewModel: ObservableObject {

    @Published var products: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    
    func fetchProducts() async {
         isLoading = true
         defer { isLoading = false }
 
         guard let url = URL(string: "https://fakestoreapi.com/products") else { return }
 
         do {
             let (data, _) = try await URLSession.shared.data(from: url)
             let decoded = try JSONDecoder().decode([Product].self, from: data)
             self.products = decoded
         } catch {
             self.errorMessage = "Failed to load products: \(error.localizedDescription)"
         }
     }

    func fetchProductsByCategory(_ category: String) async {
        isLoading = true
        defer { isLoading = false }

        let encodedCategory = category.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? category
        let urlString = "https://fakestoreapi.com/products/category/\(encodedCategory)"

        guard let url = URL(string: urlString) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            products = try JSONDecoder().decode([Product].self, from: data)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
