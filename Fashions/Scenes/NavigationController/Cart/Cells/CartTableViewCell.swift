//
//  CartTableViewCell.swift
//  Fashions
//
//  Created by Ahmed on 07/04/2023.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var cellContent: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    
    //MARK: - Variables
    
    static let ID = String(describing: CartTableViewCell.self)
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
         
    }
    
    @IBAction func quantityBtns(_ sender: Any) {
        
        
    }
}
