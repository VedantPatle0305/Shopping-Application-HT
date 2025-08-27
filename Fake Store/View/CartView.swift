//
//  CartView.swift
//  Fake Store
//
//  Created by Vedant Patle on 27/08/25.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var cartVM: CartViewModel
    @State private var showThankYou = false
    
    var body: some View {
        VStack {
            List {
                ForEach(cartVM.cartItems) { product in
                    HStack {
                        AsyncImage(url: URL(string: product.image)) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                        
                        Text(product.title)
                        Spacer()
                        Text("$\(product.price, specifier: "%.2f")")
                    }
                }
            }
            
            Button("Checkout") {
                showThankYou = true
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(12)
            .padding()
            .alert("Thank You!", isPresented: $showThankYou) {
                Button("OK", role: .cancel) {}
            }
        }
        .navigationTitle("Cart")
    }
}
