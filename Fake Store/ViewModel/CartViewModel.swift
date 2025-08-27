//
//  CartViewModel.swift
//  Fake Store
//
//  Created by Vedant Patle on 27/08/25.
//

import Foundation

@MainActor
class CartViewModel: ObservableObject {
    @Published var cartItems: [Product] = []
    
    func toggleCart(item: Product) {
        if cartItems.contains(item) {
            cartItems.removeAll { $0 == item }
        } else {
            cartItems.append(item)
        }
    }
    
    func isInCart(item: Product) -> Bool {
        return cartItems.contains(item)
    }
}

//#Preview {
//    let mockProduct = Product(
//        id: 1,
//        title: "Test Product",
//        price: 9.99,
//        description: "A sample product for preview purposes.",
//        image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
//        rating: Rating(rate: 4.5, count: 120)
//    )
//
//    let cartVM = CartViewModel()
//    cartVM.cartItems = [mockProduct]
//
//    return CartView(cartVM: cartVM) // ✅ preview a View, not ViewModel
//}
