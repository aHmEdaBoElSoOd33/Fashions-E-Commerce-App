//
//  AlertVC.swift
//  Fashions
//
//  Created by Ahmed on 02/04/2023.
//

import UIKit
import Lottie

protocol AlertVCDelegate{
    func navigate(view:UIViewController)
}



class AlertVC: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var animateView: UIView!
    @IBOutlet weak var alertTitleLbl: UILabel!
    @IBOutlet weak var alertMessageLbl: UILabel!
    //MARK: - Variables
   
    private var animationView2 : LottieAnimationView!
    var state : String?
    var alerttitle : String?
    var message : String?
    var cameFromLoginVC : Bool = false
    var delegate : AlertVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegate.self = nil
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        alert(state: state!, title: alerttitle!, message: message!)
    }
    
    func alert(state:String , title : String , message : String){
        animationView2 = .init(name: state)
        animationView2.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        animationView2.contentMode = .scaleAspectFill
        animationView2.loopMode = .loop
        animationView2.animationSpeed = 2
        animateView.addSubview(animationView2)
        animationView2.play()
        alertTitleLbl.text = alerttitle
        alertMessageLbl.text = message
    }
     
    @IBAction func okBtn(_ sender: Any) {
        if cameFromLoginVC == true{
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
//                self.delegate?.navigate(view: NavHostVC())
//            }
            let vc = NavHostVC()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            print("sss")
        }else{
            dismiss(animated: true)
        }
        
    }
}
