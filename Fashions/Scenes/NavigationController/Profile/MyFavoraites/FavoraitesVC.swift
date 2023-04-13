//
//  FavoraitesVC.swift
//  Fashions
//
//  Created by Ahmed on 13/04/2023.
//

import UIKit
import Kingfisher
class FavoraitesVC: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var wishlistCollectionview: UICollectionView!
     
    
    //MARK: - Variables
    var wishlistApi = WishlistApi()
    var wishlistArray : [WishlistData] = []
    lazy var indicatorView : UIActivityIndicatorView = {
        self.activityIndicator(style: .large , center: self.view.center)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        uisetUp()
        getWishlistDataFromApi()
    }
    //MARK: - Functions
    
    func getWishlistDataFromApi(){
        wishlistApi.getFavoriteProducts { data in
            self.wishlistArray = data
            self.wishlistCollectionview.reloadData()
            self.indicatorView.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    
    
    func uisetUp(){
        view.addSubview(indicatorView)
        indicatorView.startAnimating()
        view.isUserInteractionEnabled = false
        setupCell(collectionview: wishlistCollectionview, ID: FavoraitesCollectionViewCell.ID)
        wishlistCollectionview.dataSource = self
        wishlistCollectionview.delegate = self
          
    }
     
    
    //MARK: - IBActions
    
    @IBAction func notificationBtn(_ sender: Any) {
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

extension FavoraitesVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wishlistArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoraitesCollectionViewCell.ID, for: indexPath) as! FavoraitesCollectionViewCell
        cell.viewCell.layer.shadowColor = UIColor.black.cgColor
        cell.viewCell.layer.shadowOpacity = 0.2
        cell.viewCell.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.viewCell.layer.shadowRadius = 5
        cell.productName.text = wishlistArray[indexPath.row].product?.name
        cell.productImage.kf.setImage(with: URL(string: (wishlistArray[indexPath.row].product?.image)!))
        cell.productPrice.text = "\((wishlistArray[indexPath.row].product?.price)!)"
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height / 4)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProuductDetailsVC()
        vc.id = wishlistArray[indexPath.row].product?.id
         vc.modalPresentationStyle = .fullScreen
         present(vc, animated: true)
    }
}

