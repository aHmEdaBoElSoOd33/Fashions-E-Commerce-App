//
//  RegisterApi.swift
//  Fashions
//
//  Created by Ahmed on 11/04/2023.
//

import Foundation
import Alamofire

protocol RegisterApiDelegate{
    func RegisterIsDone(message: String,token: String)
    func RegisterIsFail(message: String)
    
   
}

protocol LoginApiDelegate{
    func LoginIsDone(massage : String,token:String)
    func LoginIsFail(massage : String)
}

protocol LogOutApiDelegate{
    func logoutIsDone(massage:String)
    func logoutIsFail(massage:String)
}
 

class RegisterApi{
    
    static let BASE_URL = "https://student.valuxapps.com/api/"
    let regesterURl = BASE_URL+"register"
    let loginURL = BASE_URL+"login" 
    let logOutUrl = RegisterApi.BASE_URL+"logout"
    var regesterDelegate : RegisterApiDelegate?
    var loginDelegate : LoginApiDelegate?
    var logOutDelegate : LogOutApiDelegate?
    
    let token = UserDefaults.standard.string(forKey: "userToken")
    
    func userRegester(_ name:String,_ email: String , _ phone:String ,_ password : String){
        
        
        let params = ["name":name, "email":email, "phone":phone, "password":password]
        let headers = HTTPHeaders(["lang" : "en"])
        
        AF.request(regesterURl, method: .post, parameters: params, encoder: .json, headers: headers).responseDecodable(of: UserRegisterModel.self){ res in
            
            if res.response?.statusCode == 200{
                
                switch res.result{
                case .success(let user):
                    UserDefaults.standard.set(user.data?.token, forKey: "userToken")
                    self.regesterDelegate?.RegisterIsDone(message: user.message!, token: user.data?.token ?? "")
                case .failure(let fail):
                    self.regesterDelegate?.RegisterIsFail(message: fail.localizedDescription)
                    print(fail.localizedDescription)
                }
            }else{
                print("Not 200") 
            }
            
        }
        
    }
    
    
    func userLogin(_ email: String , _ password : String){
         
        let params = ["email":email , "password":password]
        let headers = HTTPHeaders(["lang" : "en"])
        
        AF.request(loginURL, method: .post, parameters: params, encoder: .json, headers: headers).responseDecodable(of: UserRegisterModel.self){ res in
            
            if res.response?.statusCode == 200{
                
                switch res.result{
                case .success(let user):
                    UserDefaults.standard.set(user.data?.token, forKey: "userToken")
                    self.loginDelegate?.LoginIsDone(massage: user.message!, token: user.data?.token ?? "")
                    print(user.data?.token)
                case .failure(let fail):
                    self.loginDelegate?.LoginIsFail(massage: fail.localizedDescription)
                    print(fail.localizedDescription)
                }
            }else{
                print("Not 200")
                
            }
            
        }
    }
    
     
    
    func LogoutfromDataBase(){
        
        let header = HTTPHeaders(["lang":"en","Authorization":token!]) 
        let params = ["fcm_token":"SomeFcmToken"]
        
        AF.request(logOutUrl, method: .post, parameters : params , encoder: .json , headers:  header).responseDecodable(of: UserRegisterModel.self ){ res in
            
            if res.response?.statusCode == 200 {
                switch res.result{
                case .success(let user):
                    self.logOutDelegate?.logoutIsDone(massage: user.message!)
                    //print(user.data?.name)
                case .failure(let fail):
                    self.logOutDelegate?.logoutIsFail(massage: fail.localizedDescription)
                }
            }else {
                print (res.response?.statusCode)
            }
        }
    }
    
}
