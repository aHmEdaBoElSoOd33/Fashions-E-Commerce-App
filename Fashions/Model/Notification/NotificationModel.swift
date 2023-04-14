//
//  NotificationModel.swift
//  Fashions
//
//  Created by Ahmed on 14/04/2023.
//

import Foundation
 

// MARK: - Welcome
struct NotificationModel: Decodable {
    let data: NotfiData?
}

// MARK: - DataClass
struct NotfiData: Decodable {
     
    let data: [NotifiDataDetails]?
    
}
// MARK: - Datum
struct NotifiDataDetails: Decodable {
    let id: Int?
    let title, message: String?
}
