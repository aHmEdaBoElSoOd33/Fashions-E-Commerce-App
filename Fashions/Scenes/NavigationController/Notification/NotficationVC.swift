//
//  NotficationVC.swift
//  Fashions
//
//  Created by Ahmed on 03/04/2023.
//

import UIKit

class NotficationVC: UIViewController {

    //MARK: - IBOutlets
    
    
    @IBOutlet weak var noificationCollectionView: UICollectionView!
    
    //MARK: - Variables
    
    static var ID = String(describing: NotficationVC.self)
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
    }
     
    //MARK: - Functions
    
    func uiSetup(){
        noificationCollectionView.dataSource = self
        noificationCollectionView.delegate = self
        setupCell(collectionview: noificationCollectionView, ID: NotificationCollectionViewCell.ID)
        
    }
    

}


extension NotficationVC:UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotificationCollectionViewCell.ID, for: indexPath) as! NotificationCollectionViewCell
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height / 8)
    }
    
    
    
    
}
