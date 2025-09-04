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
    
    @Published var selectedItems: Set<Product> = []{
        didSet {
            saveSelectedItems()
        }
    }
    
    private let cartKey = "savedCart"
    private let selectedItemKey = "savedSelectedItems"
    
    init() {
        loadCart()
        loadSelectedItems()
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
//        cartItems.removeAll()
        cartItems.removeAll {selectedItems.contains($0)}
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
    
    func saveSelectedItems(){
        if let encodedData = try? JSONEncoder().encode(selectedItems) {
            UserDefaults.standard.set(encodedData, forKey: selectedItemKey)
        }
    }
    
    func loadSelectedItems(){
        if let data = UserDefaults.standard.data(forKey: selectedItemKey),
           let decoded = try? JSONDecoder().decode(Set<Product>.self, from: data) {
            selectedItems = decoded
        }
    }
    
}
