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

protocol updateProfileDelegate{
    func updateprofileIsDone(message:String)
    func updateprofileIsFail(message:String)
}


class HomeApi{
    
    let token = UserDefaults.standard.string(forKey: "userToken")
    let logOutUrl = RegisterApi.BASE_URL+"logout"
    let UserProfileUrl = RegisterApi.BASE_URL + "profile"
   
    var delegate : HomeApiDelegate?
    var profileDelegate : updateProfileDelegate?
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
     
    func updateProfile(name : String,image:Data,email:String , phone: String){
          
        print(image)
        // Set the parameters for the request
        let parameters: [String: String] = [
            "name": name,
            "email": email,
            "phone" : phone
        ]
        

        // Set the headers for the request
        let headers: HTTPHeaders = [
            "Authorization": token!,
            "lang":"en",
            "Content-Type": "application/json"
        ]

        // Set the URL for the request
        let url = "https://student.valuxapps.com/api/update-profile"

        
        
        // Send the PUT request with the image data and other parameters
        
         
        AF.upload(multipartFormData: { multipartFormData in
            // Append the image data to the request body
            multipartFormData.append(image, withName: "image", fileName: "profile_image.jpg", mimeType: "image/jpeg")
            print(name.data(using: .utf8)!)
             //Append other parameters to the request body
            for (key, value) in parameters {
                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
            }
        }, to: url, method: .put, headers: headers).responseDecodable(of: UpdateProfileResponse.self) { response in
            switch response.result {
            case .success(let data):
                 
                self.profileDelegate?.updateprofileIsDone(message: data.message)
            case .failure(let error):
                self.profileDelegate?.updateprofileIsFail(message: error.localizedDescription)
            }
        }

    }
    
     
    
}
