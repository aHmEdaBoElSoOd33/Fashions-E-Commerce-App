//
//  OrderCollectionViewCell.swift
//  Fashions
//
//  Created by Ahmed on 14/04/2023.
//

import UIKit

class OrderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var totalcostLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var orderState: UILabel!
    
    
    static var ID = String(describing: OrderCollectionViewCell.self)
    override func awakeFromNib() {
        super.awakeFromNib()
         
    }

}
