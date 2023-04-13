//
//  HomeModel.swift
//  Fashions
//
//  Created by Ahmed on 12/04/2023.
//

import Foundation

struct HomeVCModel: Decodable {
    let status: Bool?
    let data: HomeDataClass?
}

// MARK: - DataClass
struct HomeDataClass: Decodable {
    let products: [Product]?
    let banners: [Banner]?
}

// MARK: - Banner
struct Banner: Decodable {
    let id: Int?
    let image: String? 
}
// MARK: - Product
struct Product: Decodable {
    let id: Int?
    let price, oldPrice: Float?
    let discount: Int?
    let image: String?
    let name, description: String?
    let images: [String]?
    let in_favorites, in_cart: Bool?
}

