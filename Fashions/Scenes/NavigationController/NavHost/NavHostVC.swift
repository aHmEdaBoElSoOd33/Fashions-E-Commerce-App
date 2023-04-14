//
//  NavHostVC.swift
//  Fashions
//
//  Created by Ahmed on 03/04/2023.
//

import UIKit

class NavHostVC: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var hostView: UIView!
    @IBOutlet weak var tabbarBackGround: UIView!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var cartBtn: UIButton!
    
    
    //MARK: - Variables
    
    var lastSender = 2
    var navigatDelegate = HomeVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSetUp()
        
    }
    
    //MARK: - Functions
    
    func uiSetUp(){
        tabbarBackGround.layer.shadowColor = UIColor.black.cgColor
        tabbarBackGround.layer.shadowOffset = CGSize(width: 0, height: 5)
        tabbarBackGround.layer.shadowRadius = 5
        tabbarBackGround.layer.shadowOpacity = 0.5
        homeBtn.isSelected = true
        replaceV(HomeVC())
    }
    
    @objc func replaceV(_ ID:UIViewController){
        ViewEmbeder.embed(VC: ID, parent: self, container: hostView)
    }
    
    
    //MARK: - IBActions 
    
    @IBAction func tabBarBtns(_ sender: UIButton) {
        
        if let lastPressedBtn:UIButton = view.viewWithTag(lastSender) as? UIButton{
            
            UIView.transition(with: sender, duration: 0.2, options: .transitionCrossDissolve, animations: {
                lastPressedBtn.layer.add(self.animateTabBarBtn(array: [-10 , 0]), forKey: "shakee")
            }, completion: nil)
            lastPressedBtn.isSelected = false
        }
        switch sender.tag{
            
        case 2:
            sender.isSelected = true
            UIView.transition(with: sender, duration: 0.2, options: .transitionCrossDissolve, animations: {
                sender.layer.add(self.animateTabBarBtn(array: [10, 0]), forKey: "shakeee")
            }, completion: nil)
            replaceV(HomeVC())
            
        case 3:
            sender.isSelected = true
            UIView.transition(with: sender, duration: 0.2, options: .transitionCrossDissolve, animations: {
                // Change the image of the button
                sender.layer.add(self.animateTabBarBtn(array: [10 , 0]), forKey: "shakeee")
            }, completion: nil)
            replaceV(CartVC())
            
        case 4:
            sender.isSelected = true
            UIView.transition(with: sender, duration: 0.2, options: .transitionCrossDissolve, animations: {
                // Change the image of the button
                sender.layer.add(self.animateTabBarBtn(array: [10 , 0]), forKey: "shakeee")
            }, completion: nil)
            replaceV(NotficationVC())
            
        default:
            sender.isSelected = true
            UIView.transition(with: sender, duration: 0.2, options: .transitionCrossDissolve, animations: {
                // Change the image of the button
                sender.layer.add(self.animateTabBarBtn(array: [10 , 0]), forKey: "shakeee")
            }, completion: nil)
            replaceV(ProfileVC())
        }
        lastSender = sender.tag
        print(lastSender)
    }
}
         
 
