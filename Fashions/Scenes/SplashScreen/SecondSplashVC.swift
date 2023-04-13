//
//  SecondSplashVC.swift
//  Fashions
//
//  Created by Ahmed on 01/04/2023.
//

import UIKit

class SecondSplashVC: UIViewController {

    //MARK: - IBOutlets
    
    
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    
    //MARK: - Variables
    
    static let ID = String(describing: SecondSplashVC.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
    }
    
    //MARK: - Functions
    
    func uiSetup(){
        
        signUpBtn.layer.borderWidth = 2
        signUpBtn.layer.borderColor = UIColor.white.cgColor
        
    }
    
    
    
    
    //MARK: - IBActions
    
    @IBAction func loginBtn(_ sender: Any) {
        
        let vc = LoginVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
    
    
    
    @IBAction func signUpBtn(_ sender: Any) {
        let vc = RegisterVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
