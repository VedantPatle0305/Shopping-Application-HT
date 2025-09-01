//
//  apiService.swift
//  Fake Store
//
//  Created by Vedant Patle on 27/08/25.
//

import Foundation

class APIService {
    static let shared = APIService()
    private init() {}
    
    func fetchProducts() async throws -> [Product] {
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            throw URLError(.badURL)
        }
                
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode([Product].self, from: data)
    }
}
