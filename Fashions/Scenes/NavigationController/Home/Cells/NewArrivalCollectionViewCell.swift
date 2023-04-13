//
//  NewArrivalCollectionViewCell.swift
//  Fashions
//
//  Created by Ahmed on 04/04/2023.
//

import UIKit

protocol CellSubclassProductDelegate {
    func buttonTapped(cell: NewArrivalCollectionViewCell)
}

class NewArrivalCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOutlet
    
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    //MARK: - Variables
    
    static var ID = String(describing: NewArrivalCollectionViewCell.self)
    var delegate : CellSubclassProductDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        delegate.self = nil
    }

    @IBAction func addToWishlistBtn(_ sender: Any) {
        delegate?.buttonTapped(cell: self)
    }
}
