//
//  AddUpdateDeleteAdreessModel.swift
//  Fashions
//
//  Created by Ahmed on 14/04/2023.
//
 
import Foundation

struct AddUpdateDeleteAdreessModel: Decodable {
    let status: Bool?
    let message: String?
    let data: AddUpdateDeleteAdreessModelData?
}

// MARK: - DataClass
struct AddUpdateDeleteAdreessModelData: Decodable {
    let name, city, region, details: String?
    let latitude, longitude: Double?
    let notes: String?
    let id: Int?
}
