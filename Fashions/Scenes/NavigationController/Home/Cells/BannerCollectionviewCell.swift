//
//  BannerCollectionviewCell.swift
//  Fashions
//
//  Created by Ahmed on 04/04/2023.
//

import UIKit

class BannerCollectionviewCell: UICollectionViewCell {
//MARK: - IBOutlets
    
    @IBOutlet weak var bannerImage: UIImageView!
    
    
    //MARK: - Variables
    
    static var ID = String(describing: BannerCollectionviewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
