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
