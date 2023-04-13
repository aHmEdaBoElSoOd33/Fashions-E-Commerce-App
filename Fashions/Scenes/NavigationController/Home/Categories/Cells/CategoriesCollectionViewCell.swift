//
//  CategoriesCollectionViewCell.swift
//  Fashions
//
//  Created by Ahmed on 04/04/2023.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
//MARK: - IBOutlets
 
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
    @IBOutlet weak var trailingConstrainImage: NSLayoutConstraint!
    @IBOutlet weak var leadingconstrainLable: NSLayoutConstraint!
    
    
    
    //MARK: - Variables
    static let ID = String(describing: CategoriesCollectionViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
         
    }
     
    
}
