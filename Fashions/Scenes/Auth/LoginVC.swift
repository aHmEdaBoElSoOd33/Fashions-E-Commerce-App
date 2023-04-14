//
//  LoginVC.swift
//  Fashions
//
//  Created by Ahmed on 02/04/2023.
//

import UIKit

class LoginVC: UIViewController{

    //MARK: - IBOutlets
    
    @IBOutlet weak var AppleBtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    
    //MARK: - Variables
    var email = "a@g.com"
    var pass = "1111"
    var loginApi = RegisterApi()
    lazy var indicatorView : UIActivityIndicatorView = { self.activityIndicator(style:.medium,center: self.view.center)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
    }
//MARK: - Functions
   
    
    func uiSetup(){
        loginApi.loginDelegate = self
        googleBtn.layer.borderWidth = 0.1
        googleBtn.layer.borderColor = UIColor.black.cgColor
        AppleBtn.layer.borderWidth = 0.1
        AppleBtn.layer.borderColor = UIColor.black.cgColor 
    }
    
    func validateForLogin(){
        
        guard let email = emailTxtField.text, !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            showALert(message: "please enter Email")
            return
        }
        guard let password = passwordTxtField.text, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            showALert(message: "please enter Password")
            return
        }
        loginApi.userLogin(email, password)
        view.addSubview(indicatorView)
        indicatorView.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    
    
 //MARK: - IBActions
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func loginBtn(_ sender: Any) {
        
        validateForLogin()
    }
}


extension LoginVC : LoginApiDelegate {
   
    
    
    func LoginIsDone(massage: String, token: String) {
        if token == "" {
            indicatorView.stopAnimating()
            view.isUserInteractionEnabled = true
            let vc = AlertVC()
            vc.message = massage
            vc.state = "fail"
            vc.alerttitle = "Failed"
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            present(vc, animated: true)
        }else{
            indicatorView.stopAnimating()
            view.isUserInteractionEnabled = true
            let vc = AlertVC()
            vc.message = massage
            vc.state = "success"
            vc.alerttitle = "Successful"
            vc.cameFromLoginVC = true
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true)
        }
    }
    func LoginIsFail(massage: String) {
       print(massage)
    }
}
