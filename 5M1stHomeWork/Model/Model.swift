//
//  Model.swift
//  5M1stHomeWork
//
//  Created by user on 26/5/23.
//

import Foundation

// MARK: - Product
struct Products: Decodable {
    let products: [Product]
    let total, skip, limit: Int
}

// MARK: - ProductElement
struct Product: Decodable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}
