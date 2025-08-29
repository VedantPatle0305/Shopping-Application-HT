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
    
    @Published var selectedItems: Set<Product> = []
    
    private let cartKey = "savedCart"
    
    init() {
        loadCart()
    }
    
    func toggleCart(item: Product) {
        if cartItems.contains(item) {
            cartItems.removeAll { $0 == item }
            selectedItems.remove(item)
        } else {
            cartItems.append(item)
        }
    }
    
    func toggleSelection(item: Product) {
        if selectedItems.contains(item) {
            selectedItems.remove(item)
        } else {
            selectedItems.insert(item)
        }
    }
    
    func isInCart(item: Product) -> Bool {
        return cartItems.contains(item)
    }
    
    func selectAll() {
        selectedItems = Set(cartItems)
    }
    
    func deselectAll() {
        selectedItems.removeAll()
    }
    
    func isAllSelected() -> Bool {
        return !cartItems.isEmpty && selectedItems.count == cartItems.count
    }
    
    func clearCart() {
        cartItems.removeAll()
        selectedItems.removeAll()
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
