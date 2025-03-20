//
//  Product.swift
//  ProductManagement
//
//  Created by Anjali Sikarwar on 20/03/25.
//

import Foundation

struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating

    struct Rating: Codable {
        let rate: Double
        let count: Int
    }
}
