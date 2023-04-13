//
//  UIViewController.swift
//  Fashions
//
//  Created by Ahmed on 01/04/2023.
//

import Foundation
import UIKit



extension UIViewController{
    
    func setupCell(collectionview: UICollectionView , ID : String){
        let nib = UINib(nibName: ID, bundle: nil)
        collectionview.register(nib, forCellWithReuseIdentifier: ID)
    }
    
    
    func hideKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showALert(message:String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.modalTransitionStyle = .coverVertical
         self.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8 ){
            alert.dismiss(animated: true)
        }
    }
    
    
    func shakeAnimation() -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.3
        animation.values = [-10, 10, -5, 5, 0]
        return animation
    }
    
    
    
    func animateTabBarBtn(array:[Int]) -> CAKeyframeAnimation{
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.25
        animation.values =  array
        return animation
    }
    
    
    func activityIndicator(style: UIActivityIndicatorView.Style = .medium,frame: CGRect? = nil, center: CGPoint? = nil) -> UIActivityIndicatorView {
        
        let activityIndicatorView = UIActivityIndicatorView(style: style)
        
        if let frame = frame {
            activityIndicatorView.frame = frame
        }
        
        if let center = center {
            activityIndicatorView.center = center
        }
        
        return activityIndicatorView
    }
    
    
    
    
}
