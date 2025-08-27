//
//  ContentView.swift
//  Fake Store
//
//  Created by Vedant Patle on 26/08/25.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var logoScale: CGFloat = 0.8
    @State private var isVisible = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.blue.opacity(0.4)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Image("Icon") // Replace with your custom logo asset name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 140)
                    .scaleEffect(logoScale)
                    .shadow(color: .white.opacity(0.6), radius: 8, x: 0, y: 4)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                            logoScale = 1.1
                        }
                    }
                
                Text("Fake Store")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .opacity(isVisible ? 1 : 0)
                    .animation(.easeIn(duration: 0.5).delay(0.3), value: isVisible)
                
                Text("Your simple shopping experience")
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.8))
                    .opacity(isVisible ? 1 : 0)
                    .animation(.easeIn(duration: 0.5).delay(0.5), value: isVisible)
            }
        }
        .onAppear {
            isVisible = true
        }
    }
}



#Preview {
    SplashScreenView()
}
