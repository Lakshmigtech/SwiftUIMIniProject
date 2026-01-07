//
//  Untitled.swift
//  MiniSwitUI
//
//  Created by Lakshmi Sarath on 23/10/25.
//

//
//  Untitled.swift
//  MiniSwitUI
//
//  Created by Lakshmi Sarath on 23/10/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = "test@example.com"
    @State private var password: String = "123456"
    @State private var isSecure: Bool = true
    @State private var isLoading: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.6)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack(spacing: 25) {
                    // App Title
                    Text("Welcome Shopsy 👋")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    
                    // Email Field
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.4), lineWidth: 1))
                    
                    // Password Field
                    HStack {
                        if isSecure {
                            SecureField("Password", text: $password)
                                .padding()
                                .foregroundColor(.white)
                        } else {
                            TextField("Password", text: $password)
                                .padding()
                                .foregroundColor(.white)
                        }
                        
                        Button(action: { isSecure.toggle() }) {
                            Image(systemName: isSecure ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.white.opacity(0.8))
                                .padding(.trailing, 10)
                        }
                    }
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(12)
                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.white.opacity(0.4), lineWidth: 1))
              
                    // Login Button
                    Button(action: handleLogin) {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(12)
                        } else {
                            Text("Login")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.blue)
                                .fontWeight(.bold)
                                .cornerRadius(12)
                        }
                    }
                    .padding(.top, 10)
                    
                    // Sign Up Link
                    HStack {
                        Text("Don’t have an account?")
                            .foregroundColor(.white.opacity(0.8))
                        NavigationLink(destination: SignupView()) {
                            Text("Sign Up")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.top, 10)
                }
                .padding(.horizontal, 30)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Login Failed"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            .navigationDestination(isPresented: $isLoggedIn) {
                MainTabView()
            }
        }
    }
    
    func handleLogin() {
        guard !email.isEmpty, !password.isEmpty else {
            alertMessage = "Please enter both email and password."
            showAlert = true
            return
        }
        
        isLoading = true
        // Simulate login delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false
            if email == "test@example.com" && password == "123456" {
                print("Login successful")
                isLoggedIn = true
            } else {
                alertMessage = "Invalid credentials. Try again!"
                showAlert = true
            }
        }
    }
}

struct SignupView: View {
    var body: some View {
        Text("Signup Screen Placeholder")
            .font(.title)
            .foregroundColor(.gray)
    }
}

#Preview {
    LoginView()
}

