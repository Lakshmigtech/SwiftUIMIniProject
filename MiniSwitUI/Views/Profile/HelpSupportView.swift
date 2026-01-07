//
//  HelpSupportView.swift
//  MiniSwitUI
//
//  Created by Techversant on 24/12/25.
//
import SwiftUI

struct HelpSupportView: View {
    var body: some View {
        List {
            
            // MARK: - FAQ SECTION
            Section(header: Text("FAQs")) {
                NavigationLink(destination: FAQDetailView(
                    question: "How can I track my order?",
                    answer: "You can track your order from My Orders section in your profile."
                )) {
                    Label("Track my order", systemImage: "shippingbox")
                }

                NavigationLink(destination: FAQDetailView(
                    question: "What is the return policy?",
                    answer: "Products can be returned within 7 days of delivery if unused."
                )) {
                    Label("Return policy", systemImage: "arrow.uturn.left")
                }

                NavigationLink(destination: FAQDetailView(
                    question: "How do I cancel an order?",
                    answer: "Orders can be cancelled before they are shipped from My Orders."
                )) {
                    Label("Cancel an order", systemImage: "xmark.circle")
                }
            }

            // MARK: - SUPPORT SECTION
            Section(header: Text("Support")) {
                Button {
                    callSupport()
                } label: {
                    Label("Call Customer Care", systemImage: "phone.fill")
                }

                Button {
                    emailSupport()
                } label: {
                    Label("Email Support", systemImage: "envelope.fill")
                }

                NavigationLink(destination: ChatSupportView()) {
                    Label("Live Chat", systemImage: "message.fill")
                }
            }
        }
        .navigationTitle("Help & Support")
    }

    // MARK: - ACTIONS
    func callSupport() {
        if let url = URL(string: "tel://1800123456") {
            UIApplication.shared.open(url)
        }
    }

    func emailSupport() {
        if let url = URL(string: "mailto:support@yourapp.com") {
            UIApplication.shared.open(url)
        }
    }
}
struct FAQDetailView: View {
    let question: String
    let answer: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(question)
                    .font(.title3)
                    .bold()

                Text(answer)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .navigationTitle("Help")
    }
}
struct ChatSupportView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "message.circle.fill")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.blue)

            Text("Live Chat Support")
                .font(.title2)
                .bold()

            Text("Our support team will be available soon.")
                .foregroundColor(.gray)
        }
        .padding()
        .navigationTitle("Chat Support")
    }
}
