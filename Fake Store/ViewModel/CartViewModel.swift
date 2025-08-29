//
//  CartViewModel.swift
//  Fake Store
//
//  Created by Vedant Patle on 27/08/25.
//

import Foundation

@MainActor
class CartViewModel: ObservableObject {
    @Published var cartItems: [Product] = []{
        didSet {
            saveCart()
        }
    }
    
    private let cartKey = "savedCart"
    
    init() {
        loadCart()
    }
    
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
    
    func clearCart() {
        cartItems.removeAll()
    }
    
    func saveCart() {
        if let encodedData = try? JSONEncoder().encode(cartItems) {
            UserDefaults.standard.set(encodedData, forKey: cartKey)
        }
    }
    
    func loadCart() {
        if let data = UserDefaults.standard.data(forKey: cartKey),
           let decoded = try? JSONDecoder().decode([Product].self, from: data) {
            cartItems = decoded
        }
    }
    
}
