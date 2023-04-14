//
//  NotificationApi.swift
//  Fashions
//
//  Created by Ahmed on 14/04/2023.
//

import Foundation
import Alamofire


class NotificationApi{
    let NotificationUrl = RegisterApi.BASE_URL + "notifications"
    
    func getHomeData(completion:@escaping([NotifiDataDetails]?,Error?)->Void){
        
        let header = HTTPHeaders(["lang":"en"])
        AF.request(NotificationUrl, method: .get,headers: header ).responseDecodable(of: NotificationModel.self ){ res in
          if res.response?.statusCode == 200 {
                switch res.result {
                case .success(let user):
                    completion((user.data?.data)!, nil)
                case .failure(let fail):
                    completion(nil,fail)
                }
            }else{
                
                print("Not 200")
                
            }
        }
    }
}
