//
//  ProductDetailView.swift
//  Fake Store
//
//  Created by Vedant Patle on 27/08/25.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @ObservedObject var cartVM: CartViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: product.image!)) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 200)
                
                Text(product.title!)
                    .font(.title)
                    .bold()
                
                Text(product.description!)
                    .font(.body)
                
                Text("Price: $\(product.price!, specifier: "%.2f")")
                    .font(.title2)
                    .foregroundColor(.green)
                
                Text("⭐️ \(product.rating.rate!, specifier: "%.1f") (\(product.rating.count!) reviews)")
                    .foregroundColor(.orange)
                
                Button {
                    cartVM.toggleCart(item: product)
                } label: {
                    Label(cartVM.isInCart(item: product) ? "Remove from Cart" : "Add to Cart",
                          systemImage: "cart")
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .padding()
        }
    }
}

//#Preview {
//    ProductDetailView()
//}
