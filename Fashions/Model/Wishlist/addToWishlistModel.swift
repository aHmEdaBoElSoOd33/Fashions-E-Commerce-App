//
//  addToWishlistModel.swift
//  Fashions
//
//  Created by Ahmed on 13/04/2023.
//

import Foundation

// MARK: - AddWishlistModel
struct AddWishlistModel : Decodable {
    let status: Bool?
    let message: String?
    let data: AddWishlistModelData?
}

// MARK: - AddWishlistModelData
struct AddWishlistModelData: Decodable {
    let id: Int?
    let product: AddWishlistProduct?
}

// MARK: - AddWishlistProduct
struct AddWishlistProduct: Decodable {
    let id, price, oldPrice, discount: Int?
    let image: String?
}
