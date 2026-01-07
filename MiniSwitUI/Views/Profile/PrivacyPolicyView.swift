//
//  PrivacyPolicyView.swift
//  MiniSwitUI
//
//  Created by Techversant on 22/12/25.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Privacy Policy")
                .font(.title2)
                .bold()

            Link(
                "Read our Privacy Policy",
                destination: URL(string: "https://www.iubenda.com/en/help/26095-privacy-policy-ecommerce-stores")!
            )
            .font(.body)
            .foregroundColor(.blue)
        }
        .padding()
    }
}
