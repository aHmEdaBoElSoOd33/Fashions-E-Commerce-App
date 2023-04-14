//
//  OrderModel.swift
//  Fashions
//
//  Created by Ahmed on 14/04/2023.
//
  
import Foundation
// MARK: - Welcome
struct OrderModel: Decodable {
    let data: OrderModelData?
}

// MARK: - DataClass
struct OrderModelData: Decodable {
    let data: [OrderModelDataDetails]?
}

// MARK: - Datum
struct OrderModelDataDetails: Decodable {
    let id: Int?
    let total: Double?
    let date, status: String?
}
