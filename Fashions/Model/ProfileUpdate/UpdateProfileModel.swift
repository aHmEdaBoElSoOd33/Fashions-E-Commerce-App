//
//  UpdateProfileModel.swift
//  Fashions
//
//  Created by Ahmed on 15/04/2023.
//

 
import Foundation

// MARK: - Welcome
struct UpdateProfileResponse: Decodable {
    let message: String
    // Add other properties as needed to match the response from the server
}


struct UpdateProfileModel: Decodable {
 
    let message: String?
    let data: UpdateProfileModelData?
}

// MARK: - DataClass
struct UpdateProfileModelData: Decodable {
    let id: Int?
    let name, email, phone: String?
    let image: String?
    let points: Int?
    let credit: Double?
    let token: String?
}
