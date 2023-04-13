//
//  CategoriesModel.swift
//  Fashions
//
//  Created by Ahmed on 12/04/2023.
//

import Foundation 

struct AllCategories : Decodable {
    let status: Bool?
    let data : Category?
}


struct Category : Decodable {
    let data: [Datum]?
    let total : Int?
}

struct Datum : Decodable {
    let id: Int?
    let name: String?
    let image: String?
}
