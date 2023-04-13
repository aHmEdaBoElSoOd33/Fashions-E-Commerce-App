//
//  loginSuccessAlertVC.swift
//  Fashions
//
//  Created by Ahmed on 03/04/2023.
//

import UIKit

class loginSuccessAlertVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
 
    @IBAction func goHomeBtn(_ sender: Any) {
        
        let vc = NavHostVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
}
