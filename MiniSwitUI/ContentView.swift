//
//  ContentView.swift
//  MiniSwitUI
//
//  Created by Lakshmi Sarath on 21/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var greeting = "Hello there 👋"
    @State private var buttonTapped = false

    var body: some View {
        VStack(spacing: 20) {
            // Profile Image
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 120, height: 120)
                .foregroundStyle(.blue)
                .padding(.top, 80)

            // Name
            Text("Lakshmi G")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.primary)

            // Greeting Text
            Text(greeting)
                .font(.headline)
                .foregroundStyle(.secondary)
                .padding(.vertical, 10)

            // Tap Me Button
            Button(action: {
                withAnimation {
                    buttonTapped.toggle()
                    greeting = buttonTapped ? "Welcome to SwiftUI 🎉" : "Hello there 👋"
                }
            }) {
                Text("Tap Me")
                    .font(.headline)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(radius: 4)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
        .ignoresSafeArea()
    }
}




#Preview {
    ContentView()
}
