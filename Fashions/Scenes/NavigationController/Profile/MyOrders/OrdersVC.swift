//
//  OrdersVC.swift
//  Fashions
//
//  Created by Ahmed on 14/04/2023.
//

import UIKit

class OrdersVC: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var newBtn: UIButton!
    
    @IBOutlet weak var cancelledBtn: UIButton!
    
    
    //MARK: - Variables
    
    var lastSender = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
    }
    //MARK: - Functions
    func uiSetup(){
         
        cancelledBtn.layer.borderColor = UIColor.lightGray.cgColor
        cancelledBtn.layer.borderWidth = 0.5
        newBtn.isSelected = true 
        newBtn.backgroundColor = .black
        newBtn.layer.borderWidth = 0
    }
    
    
    
    //MARK: - IBActions
    @IBAction func switchCollectionNewAndCancelBtns(_ sender: UIButton) {
        if let lastPressedBtn:UIButton = view.viewWithTag(lastSender) as? UIButton{
            lastPressedBtn.isSelected = false
            lastPressedBtn.titleLabel?.textColor = UIColor.lightGray
            lastPressedBtn.backgroundColor = .clear
            lastPressedBtn.layer.borderColor = UIColor.lightGray.cgColor
            lastPressedBtn.layer.borderWidth = 0.5
        }
        switch sender.tag{
        case 3:
            sender.isSelected = true
            sender.titleLabel?.textColor = UIColor.white
            sender.backgroundColor = .black
            sender.layer.borderWidth = 0
        default:
            sender.isSelected = true
            sender.titleLabel?.textColor = UIColor.white
            sender.backgroundColor = .black
            sender.layer.borderWidth = 0
        }
        lastSender = sender.tag
        print(lastSender)
    }
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
}
    

