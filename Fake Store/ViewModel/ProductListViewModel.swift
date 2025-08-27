//
//  ProductsViewModel.swift
//  Fake Store
//
//  Created by Vedant Patle on 27/08/25.
//

import Foundation

@MainActor
class ProductListViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func loadProducts() async {
        isLoading = true
        do {
            products = try await APIService.shared.fetchProducts()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}

