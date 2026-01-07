//
//  signup.swift
//  MiniSwitUI
//
//  Created by Techversant on 16/12/25.
//

import SwiftUI

struct SignupView: View {

    @State private var fullName = ""
    @State private var email = ""
    @State private var mobile = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var agreeTerms = false
    @State private var isLoading = false
    @State private var errorMessage = ""
    @State private var navigateToLogin = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                // MARK: - Header
                VStack(spacing: 10) {
                    Image(systemName: "cart.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.blue)

                    Text("Create Account")
                        .font(.title)
                        .fontWeight(.bold)

                    Text("Sign up to start shopping")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.top, 40)

                // Hidden NavigationLink for programmatic navigation
                NavigationLink(destination: LoginView(), isActive: $navigateToLogin) {
                    EmptyView()
                }
                .hidden()

                // MARK: - Input Fields
                Group {
                    inputField(title: "Full Name", text: $fullName)
                    inputField(title: "Email", text: $email, keyboard: .emailAddress)
                    inputField(title: "Mobile Number", text: $mobile, keyboard: .numberPad)
                    secureField(title: "Password", text: $password)
                    secureField(title: "Confirm Password", text: $confirmPassword)
                }

                // MARK: - Terms
                Toggle(isOn: $agreeTerms) {
                    Text("I agree to Terms & Privacy Policy")
                        .font(.footnote)
                }
                .toggleStyle(SwitchToggleStyle(tint: .blue))

                // MARK: - Error Message
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                }

                // MARK: - Signup Button
                Button(action: signUp) {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(isFormValid ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(12)
                .disabled(!isFormValid || isLoading)

                // MARK: - Login Navigation
                HStack {
                    Text("Already have an account?")
                        .foregroundColor(.gray)
                    Button("Login") {
                        navigateToLogin = true
                        // Navigate to LoginView
                    }
                }
                .padding(.bottom, 40)
            }
            .padding()
        }
    }

    // MARK: - Validation
    var isFormValid: Bool {
        !fullName.isEmpty &&
        email.contains("@") &&
        mobile.count >= 10 &&
        password.count >= 6 &&
        password == confirmPassword &&
        agreeTerms
    }

    // MARK: - Actions
    func signUp() {
        errorMessage = ""
        isLoading = true

        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
            print("User Signed Up Successfully")
            navigateToLogin = true
        }
    }

    // MARK: - Reusable Components
    func inputField(
        title: String,
        text: Binding<String>,
        keyboard: UIKeyboardType = .default
    ) -> some View {
        TextField(title, text: text)
            .keyboardType(keyboard)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
    }

    func secureField(title: String, text: Binding<String>) -> some View {
        SecureField(title, text: text)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
    }
}
