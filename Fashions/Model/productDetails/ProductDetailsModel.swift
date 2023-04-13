//
//  ProductDetailsModel.swift
//  Fashions
//
//  Created by Ahmed on 13/04/2023.
//

import Foundation

struct ProductDetails: Decodable {
   let data: ProductDetailsInfo?
}

struct ProductDetailsInfo: Decodable {
   let id, price, oldPrice, discount: Int?
   let image: String?
   let name, description: String?
   let in_favorites, in_cart: Bool?
   let images: [String]?
}
