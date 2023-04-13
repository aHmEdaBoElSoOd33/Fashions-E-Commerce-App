//
//  CategoriesDetails.swift
//  Fashions
//
//  Created by Ahmed on 12/04/2023.
//
 
import Foundation
 
struct AllcategoriesDetails: Decodable {
    let status: Bool?
    let data: DataDetais?
}

// MARK: - DataClass
struct DataDetais : Decodable {
    let data: [categoryDetails]?
}

// MARK: - Datum
struct categoryDetails: Decodable {
    let id: Int?
    let price, oldPrice: Double?
    let discount: Int?
    let image: String?
    let name, description: String?
    let images: [String]?
    let in_favorites, in_cart: Bool
}
