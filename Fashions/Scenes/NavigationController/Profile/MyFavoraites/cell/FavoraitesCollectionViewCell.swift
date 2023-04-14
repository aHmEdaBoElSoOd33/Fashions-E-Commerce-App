//
//  FavoraitesCollectionViewCell.swift
//  Fashions
//
//  Created by Ahmed on 13/04/2023.
//

import UIKit

protocol CellSubclassWishlistDelegate {
    func buttonTapped(cell: FavoraitesCollectionViewCell)
}
 

class FavoraitesCollectionViewCell: UICollectionViewCell {
    //MARK: - IBOutlets
    
    @IBOutlet weak var addToCartBtn: UIButton!
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    
    //MARK: - Variables
    var delegate : CellSubclassWishlistDelegate?
    static let ID = String(describing: FavoraitesCollectionViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        delegate.self = nil
    }
    @IBAction func addToCartBtn(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "Add to Cart"{
            sender.setTitle("Remove from Cart", for: .normal)
        }else{
            sender.setTitle("Add to Cart", for: .normal)
        }
        delegate?.buttonTapped(cell: self)
    }
     
}
