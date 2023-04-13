//
//  ViewEmbedder.swift
//  Fashions
//
//  Created by Ahmed on 03/04/2023.
//
import Foundation
import UIKit

class ViewEmbeder{
    
    class func embed(
        parent:UIViewController,
        container:UIView,
        child:UIViewController){
            
            child.willMove(toParent: parent)
            parent.addChild(child)
            container.addSubview(child.view)
            child.beginAppearanceTransition(true, animated: true)
            child.didMove(toParent: parent)
            let w = container.frame.size.width
            let h = container.frame.size.height
            child.view.frame = CGRect(x: 0, y: 0, width: w, height: h)
    }
    
    
    class func embed(VC : UIViewController, parent:UIViewController, container:UIView ){
        
         
        let vc = VC
        embed(
            parent: parent,
            container: container,
            child: vc)
    }
     
     
}
   
