//
//  UserRegisterModel.swift
//  Fashions
//
//  Created by Ahmed on 11/04/2023.
//

import Foundation

struct UserRegisterModel: Decodable {
    let status: Bool?
    let message: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Decodable {
    let name, phone, email: String?
    let id: Int?
    let image: String?
    let token: String?
}
