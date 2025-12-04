//
//  AuthModel.swift
//  MiniSwitUI
//
//  Created by Techversant on 04/12/25.
//
import Foundation


class AuthViewModel: ObservableObject {
    @Published var isLoggedIn = false

    func login(email: String, password: String) {
        // For demo
        isLoggedIn = true
    }

    func logout() {
        isLoggedIn = false
    }
}
