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
    var notificationApi = NotificationApi()
    var notificationArray : [NotifiDataDetails] = []
    lazy var indicatorView : UIActivityIndicatorView = { self.activityIndicator(style: .large,center: self.view.center)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
        getNotificationDataFromApi()
    }
     
    //MARK: - Functions
    
    func uiSetup(){
        view.addSubview(indicatorView)
        indicatorView.startAnimating()
        noificationCollectionView.dataSource = self
        noificationCollectionView.delegate = self
        setupCell(collectionview: noificationCollectionView, ID: NotificationCollectionViewCell.ID)
        
    }
    
    func getNotificationDataFromApi(){
        notificationApi.getHomeData { data, err in
            self.notificationArray = data!
            self.noificationCollectionView.reloadData()
            self.indicatorView.stopAnimating()
        }
    }
    
}


extension NotficationVC:UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notificationArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotificationCollectionViewCell.ID, for: indexPath) as! NotificationCollectionViewCell
        cell.notificationTitle.text = notificationArray[indexPath.row].title
        cell.notificationMessage.text = notificationArray[indexPath.row].message
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height / 8)
    }
    
    
    
    
}
