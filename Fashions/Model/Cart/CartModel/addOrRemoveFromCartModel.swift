//
//  addOrRemoveFromCartModel.swift
//  Fashions
//
//  Created by Ahmed on 13/04/2023.
//

import Foundation
   
// MARK: - AddToCartModel
struct AddToCartModel: Decodable {
    let status: Bool?
    let message: String?
    let data: AddToCartDataModel?
}
// MARK: - AddToCartDataModel
struct AddToCartDataModel: Decodable {
    let id, quantity: Int?
    let product: AddToCartProduct?
}

// MARK: - AddToCartProduct
struct AddToCartProduct: Decodable {
    let id: Int?
    let price, oldPrice: Double?
    let discount: Int?
    let image: String?
    let name, description: String?
}
