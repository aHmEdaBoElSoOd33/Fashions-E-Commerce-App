//
//  OnboardingCell.swift
//  Fashions
//
//  Created by Ahmed on 01/04/2023.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    
    @IBOutlet weak var siderImage: UIImageView!
    @IBOutlet weak var sliderTitle: UILabel!
    
    
    //MARK: - Variables
    
    static let ID = String(describing: OnboardingCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
         
    }

}
