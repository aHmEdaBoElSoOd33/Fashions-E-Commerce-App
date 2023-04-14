//
//  ProfileVC.swift
//  Fashions
//
//  Created by Ahmed on 03/04/2023.
//

import UIKit

class ProfileVC: UIViewController {
   
    

    //MARK: - IBOutlets
    
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    
    @IBOutlet weak var userEmailLbl: UILabel!
     
    
    //MARK: - Variables
    
    static var ID = String(describing: ProfileVC.self)
    var homeApi = HomeApi()
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
    }

    
    //MARK: - Functions
    
    func uiSetup(){
        if UserDefaults.standard.string(forKey: "userName") == nil{
            homeApi.delegate = self
            getProfileData()
        }else{
            userNameLbl.text = UserDefaults.standard.string(forKey: "userName")
            userEmailLbl.text = UserDefaults.standard.string(forKey: "userEmail")
            userImage.kf.setImage(with: URL(string: UserDefaults.standard.string(forKey: "userImage")!))
        }
        
        
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
    
    func getProfileData(){
        homeApi.getUserProfileData()
    }
    
    
    //MARK: - IBActions
    
    @IBAction func personalDetailsBtn(_ sender: Any) {
        navigtaToAnotherView(VC: PersonalDetailsVC())
    }
    
    @IBAction func myOrdersBtn(_ sender: Any) {
        navigtaToAnotherView(VC: OrdersVC())
    }
    
    @IBAction func myFavoraitesBtn(_ sender: Any) {
         navigtaToAnotherView(VC: FavoraitesVC())
    }
    
    @IBAction func shippingAdressBtn(_ sender: Any) {
        navigtaToAnotherView(VC: ShippingAddressVC())
    }
    
    @IBAction func settingsBtn(_ sender: Any) {
    }
    
    @IBAction func FAQsBtn(_ sender: Any) {
    }
    
    
    @IBAction func communityBtn(_ sender: Any) {
    }
    

    
}



extension ProfileVC : HomeApiDelegate{
    func profireDataIsDone(Data: DataClass) {
        userNameLbl.text = Data.name
        userEmailLbl.text = Data.email
        userImage.kf.setImage(with: URL(string: Data.image!))
    }
    
    func profileDataIsFail(masssage: String) {
        showALert(message: masssage)
    }
    
}
