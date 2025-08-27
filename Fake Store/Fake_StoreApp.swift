//
//  Fake_StoreApp.swift
//  Fake Store
//
//  Created by Vedant Patle on 26/08/25.
//

import SwiftUI

@main
struct Fake_StoreApp: App {
    @State private var showSplash = true
    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashScreenView()
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                            showSplash = false
                        }
                    }
            } else {
                ProductItemView()
            }
        }
    }
}
