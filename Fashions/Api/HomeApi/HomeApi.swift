//
//  HomeApi.swift
//  Fashions
//
//  Created by Ahmed on 12/04/2023.
//

import Foundation
import Alamofire


protocol HomeApiDelegate{
    
    func profireDataIsDone(Data: DataClass)
    func profileDataIsFail(masssage: String)
}

class HomeApi{
    
    let token = UserDefaults.standard.string(forKey: "userToken")
    let logOutUrl = RegisterApi.BASE_URL+"logout"
    let UserProfileUrl = RegisterApi.BASE_URL + "profile"
   
    var delegate : HomeApiDelegate?
    
    func getUserProfileData(){
        let header = HTTPHeaders(["lang":"en","Authorization":token!])
        let params : [String:String]? = nil
        
        AF.request(UserProfileUrl, method: .get, parameters : params , encoder: .json , headers:  header).responseDecodable(of: UserRegisterModel.self ){ res in
            if res.response?.statusCode == 200 {
                switch res.result{
                case .success(let user):
                    self.delegate?.profireDataIsDone(Data: user.data!)
                    print(user.data?.name)
                case .failure(let fail):
                    self.delegate?.profileDataIsFail(masssage:fail.localizedDescription)
                }
            }else {
                print ("not 200")
            }
        }
    }
    let homeUrl = RegisterApi.BASE_URL + "home"
    
    func getHomeData(completion:@escaping([Product]?,[Banner]?,Error?)->Void){
        
        let header = HTTPHeaders(["lang":"en","Authorization":token!])
        AF.request(homeUrl, method: .get,headers: header ).responseDecodable(of: HomeVCModel.self ){ res in
          if res.response?.statusCode == 200 {
                switch res.result {
                case .success(let user):
                    completion((user.data?.products)!, user.data?.banners, nil)
                case .failure(let fail):
                    completion(nil, nil, fail)
                }
            }else{
                
                print("Not 200")
                
            }
        }
    } 
}
