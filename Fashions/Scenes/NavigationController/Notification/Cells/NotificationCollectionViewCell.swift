//
//  NotificationCollectionViewCell.swift
//  Fashions
//
//  Created by Ahmed on 07/04/2023.
//

import UIKit

class NotificationCollectionViewCell: UICollectionViewCell {
//MARK: - IBOutlets
    
    @IBOutlet weak var notificationMessage: UILabel!
    @IBOutlet weak var notificationTitle: UILabel!
    
    //MARK: - Variables
    static let ID = String(describing: NotificationCollectionViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
         
    }

}
