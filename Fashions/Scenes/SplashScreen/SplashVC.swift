//
//  SplashVC.swift
//  Fashions
//
//  Created by Ahmed on 01/04/2023.
//

import UIKit

class SplashVC: UIViewController {

    static let ID = String(describing: SplashVC.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1 ){
            if UserDefaults.standard.bool(forKey: "OnBoardingShowed"){
                if UserDefaults.standard.string(forKey: "userToken") == nil{
                    let vc = SecondSplashVC()
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                }else{
                    let vc = NavHostVC()
                    vc.modalTransitionStyle = .crossDissolve
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                }
            }else{
                let vc = OnBoardingVC()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
        }
    }

}
