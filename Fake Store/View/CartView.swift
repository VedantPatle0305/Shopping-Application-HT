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
    
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            HStack{
                Image(systemName: "location.circle.fill")
                    .renderingMode(.original)
                
                Text("Apt 5B, Springfield, CA")
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding()
            .frame(width: screenWidth*0.9, height: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            )
            
            if cartVM.cartItems.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "cart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray)
                                    
                    Text("Your cart is empty")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                .frame(maxHeight: .infinity)
            }
            else{
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
                                .lineLimit(2)
                            Spacer()
                            Text("$\(product.price, specifier: "%.2f")")
                        }
                        .padding()
                        .frame(width: screenWidth*0.9)
                        .cornerRadius(10)
                    }
                    .onDelete { indexSet in
                        cartVM.cartItems.remove(atOffsets: indexSet)
                    }
                }
                .listStyle(.plain)
                .frame(width: screenWidth)
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
            .disabled(cartVM.cartItems.isEmpty)
            .opacity(cartVM.cartItems.isEmpty ? 0.9 : 1)
            .alert("Thank You!", isPresented: $showThankYou) {
                Button("OK", role: .cancel) {
                    cartVM.clearCart()
                }
            }
        }
        .navigationTitle("Cart")
    }
}

#Preview {
    let mockProduct = Product(
        id: 15,
        title: "BIYLACLESEN Women's 3-in-1 Snowboard Jacket Winter Coats",
        price: 19.99,
        description: "Note:The Jackets is US standard size, Please choose size as your usual wear Material: 100% Polyester; Detachable Liner Fabric: Warm Fleece. Detachable Functional Liner: Skin Friendly, Lightweigt and Warm.Stand Collar Liner jacket, keep you warm in cold weather. Zippered Pockets: 2 Zippered Hand Pockets, 2 Zippered Pockets on Chest (enough to keep cards or keys)and 1 Hidden Pocket Inside.Zippered Hand Pockets and Hidden Pocket keep your things secure. Humanized Design: Adjustable and Detachable Hood and Adjustable cuff to prevent the wind and water,for a comfortable fit. 3 in 1 Detachable Design provide more convenience, you can separate the coat and inner as needed, or wear it together. It is suitable for different season and help you adapt to different climates",
        image: "https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_t.png",
        rating: Rating(rate: 4.5, count: 120)
    )

    let cartVM = CartViewModel()
    cartVM.cartItems = [mockProduct]

    return CartView(cartVM: cartVM) // ✅ preview a View, not ViewModel
}
