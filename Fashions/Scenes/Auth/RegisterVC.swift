//
//  RegisterVC.swift
//  Fashions
//
//  Created by Ahmed on 02/04/2023.
//

import UIKit

class RegisterVC: UIViewController {
    //MARK: - IBOutlets
    
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var termsCheckBtn: UIButton!
     
    
    //MARK: -  Variables
    
    
    var termBtnIsSelected = false
    var registerApi = RegisterApi()
    lazy var indicatorView : UIActivityIndicatorView = { self.activityIndicator(style:.medium,center: self.view.center)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        registerApi.regesterDelegate = self
         
    }
    //MARK: - Functions
     
    
    func validateForRegister(){
        
        guard let name = usernameTxtField.text, !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            showALert(message: "please enter Username")
            return
        }
        
        guard let email = emailTxtField.text, !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            showALert(message: "please enter Email")
            return
        }
        
        guard let phone = phoneTxtField.text, !phone.trimmingCharacters(in: .whitespaces).isEmpty else {
            showALert(message: "please enter Phone")
            return
        }
        guard let password = passwordTxtField.text, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            showALert(message: "please enter Password")
            return
        }
        
        if termBtnIsSelected{
            registerApi.userRegester(name, email, phone, password)
            view.addSubview(indicatorView)
            indicatorView.startAnimating()
            view.isUserInteractionEnabled = false
        }else{
            termsCheckBtn.layer.add(shakeAnimation(), forKey: "shake")
            termsCheckBtn.tintColor = .red
        }
        
    }
    
     
    
    //MARK: - IBActions
    
    
    
    @IBAction func termsCheckBtn(_ sender: Any) {
        if termBtnIsSelected {
            termsCheckBtn.setImage(UIImage(systemName: "square"), for: .normal)
            termsCheckBtn.tintColor = .lightGray
            termBtnIsSelected = false
        }else{
            termsCheckBtn.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            termsCheckBtn.tintColor = .green
            termBtnIsSelected = true
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func loginBtn(_ sender: Any) {
        validateForRegister()
    }
}
 

extension RegisterVC : RegisterApiDelegate{
    func RegisterIsDone(message: String, token: String) {
        if token == "" {
            indicatorView.stopAnimating()
            view.isUserInteractionEnabled = true
            let vc = AlertVC()
            vc.message = message
            vc.state = "fail"
            vc.alerttitle = "Failed"
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            present(vc, animated: true)
        }else{
            indicatorView.stopAnimating()
            view.isUserInteractionEnabled = true
            let vc = loginSuccessAlertVC()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    func RegisterIsFail(message: String) {
        indicatorView.stopAnimating()
        view.isUserInteractionEnabled = true
      showALert(message: message)
    } 
}
