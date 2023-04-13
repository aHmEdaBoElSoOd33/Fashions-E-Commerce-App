//
//  AddressCollectionViewCell.swift
//  Fashions
//
//  Created by Ahmed on 13/04/2023.
//

import UIKit

class AddressCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var addressNameLbl: UILabel!
    //MARK: - Variables
    
    static let ID = String(describing: AddressCollectionViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
