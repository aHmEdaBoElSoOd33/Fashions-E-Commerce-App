//
//  FavoraitesCollectionViewCell.swift
//  Fashions
//
//  Created by Ahmed on 13/04/2023.
//

import UIKit

class FavoraitesCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var viewCell: UIView!
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    
    //MARK: - Variables
    
    static let ID = String(describing: FavoraitesCollectionViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
         
    }

}
