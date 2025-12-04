//
//  Profile.swift
//  MiniSwitUI
//
//  Created by Techversant on 04/12/25.
//

import SwiftUI


struct ProfileView: View {
    @EnvironmentObject var auth: AuthViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Profile")
                .font(.largeTitle)

            Button("Logout") {
                auth.logout()
            }
            .foregroundColor(.red)

            Spacer()
        }
        .padding()
    }
}

