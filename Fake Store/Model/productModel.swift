//
//  productModel.swift
//  Fake Store
//
//  Created by Vedant Patle on 26/08/25.
//

import Foundation

struct Rating: Codable {
    let rate: Double
    let count: Int
}

struct Product: Codable, Identifiable, Equatable{
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let title: String
    let price: Double
    let description: String
    let image: String
    let rating: Rating
}

