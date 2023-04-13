//
//  ProfileVC.swift
//  Fashions
//
//  Created by Ahmed on 03/04/2023.
//

import UIKit

class ProfileVC: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    
     
    
    //MARK: - Variables
    
    static var ID = String(describing: ProfileVC.self)
    var logoutApi = RegisterApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        uiSetup()
    }

    
    //MARK: - Functions
    
    func uiSetup(){
        logoutApi.logOutDelegate = self
        
        view1.layer.borderColor = UIColor.lightGray.cgColor
        view3.layer.borderColor = UIColor.lightGray.cgColor
        view1.layer.borderWidth = 0.5
        view3.layer.borderWidth = 0.5
         
        view2.layer.shadowColor = UIColor.black.cgColor
        view2.layer.shadowOpacity = 0.1
        view2.layer.shadowOffset = CGSize(width: 0, height: 10)
        view2.layer.shadowRadius = 15
        
        
    }
    
    func navigtaToAnotherView(VC:UIViewController){
        let vc = VC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    //MARK: - IBActions
    
    @IBAction func personalDetailsBtn(_ sender: Any) {
    }
    
    @IBAction func myOrdersBtn(_ sender: Any) {
    }
    
    @IBAction func myFavoraitesBtn(_ sender: Any) {
         navigtaToAnotherView(VC: FavoraitesVC())
    }
    
    @IBAction func shippingAdressBtn(_ sender: Any) {
    }
    
    @IBAction func settingsBtn(_ sender: Any) {
    }
    
    @IBAction func FAQsBtn(_ sender: Any) {
    }
    
    
    @IBAction func communityBtn(_ sender: Any) {
    }
    
    @IBAction func logOutBtn(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "userToken")
        logoutApi.LogoutfromDataBase()
        let vc = SecondSplashVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}



extension ProfileVC : LogOutApiDelegate{
    func logoutIsDone(massage: String) {
        print(massage)
        
    }
    
    func logoutIsFail(massage: String) {
        print(massage)
    }
    
    
}
