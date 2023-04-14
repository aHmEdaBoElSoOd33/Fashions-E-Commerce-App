//
//  PersonalDetailsVC.swift
//  Fashions
//
//  Created by Ahmed on 14/04/2023.
//

import UIKit

class PersonalDetailsVC: UIViewController {
//MARK: - IBOutlets
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNametxtField: UITextField!
    @IBOutlet weak var EmailtxtField: UITextField!
    @IBOutlet weak var phoneTxtField: UITextField!
    
    //MARK: - Variables
    var logoutApi = RegisterApi()
    var homeApi = HomeApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoutApi.logOutDelegate = self
        uiSetup()
        // Do any additional setup after loading the view.
    }
  
    //MARK: - Functions
    
    func getProfileData(){
        homeApi.getUserProfileData()
    }
     
    func uiSetup(){
        if UserDefaults.standard.string(forKey: "userName") == nil{
            homeApi.delegate = self
            getProfileData()
        }else{
            phoneTxtField.text = UserDefaults.standard.string(forKey: "userPhone")
            userNametxtField.text = UserDefaults.standard.string(forKey: "userName")
            EmailtxtField.text = UserDefaults.standard.string(forKey: "userEmail")
            userImage.kf.setImage(with: URL(string: UserDefaults.standard.string(forKey: "userImage")!))
        }
        
    }
    
    
    
    
    @IBAction func logOutBtn(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "userToken")
        UserDefaults.standard.set(nil, forKey: "userPhone")
        UserDefaults.standard.set(nil, forKey: "userName")
        UserDefaults.standard.set(nil, forKey: "userEmail")
        UserDefaults.standard.set(nil, forKey: "userImage")
        logoutApi.LogoutfromDataBase()
        let vc = SecondSplashVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
  
}


extension PersonalDetailsVC : LogOutApiDelegate, HomeApiDelegate{
    
    func profireDataIsDone(Data: DataClass) {
        userNametxtField.text = Data.name
        EmailtxtField.text = Data.email
        userImage.kf.setImage(with: URL(string: Data.image!))
    }
    
    func profileDataIsFail(masssage: String) {
        showALert(message: masssage)
    }
    
    
    func logoutIsDone(massage: String) {
        print(massage)
        
    }
    
    func logoutIsFail(massage: String) {
        print(massage)
    }
}
