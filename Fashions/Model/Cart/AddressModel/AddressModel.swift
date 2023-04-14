//
//  AddressModel.swift
//  Fashions
//
//  Created by Ahmed on 14/04/2023.
//
 
import Foundation
struct Address: Decodable {
    let status: Bool?
    let message: String?
    let data: AddressData?
}

// MARK: - AddressData
struct AddressData: Decodable {
    let data: [AddressDetailsData]?
}

// MARK: - AddressDetailsData
struct AddressDetailsData: Decodable {
    let id: Int?
    let name, city, region, details: String?
    let notes: String?
    let latitude, longitude: Double?
}
