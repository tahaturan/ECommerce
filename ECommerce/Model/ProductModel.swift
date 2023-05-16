//
//  ProductModel.swift
//  ECommerce
//
//  Created by Taha Turan on 16.05.2023.
//

import Foundation

// MARK: - ProductModel
struct ProductModel: Codable {
    let id: Int
    let title: String
    let price: Double
    let description, category: String
    let image: String
    let rating: Rating
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}
