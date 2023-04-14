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
     
    var cartApi = CartApi()
    var wishlistApi = WishlistApi()
    var wishlistArray : [WishlistData] = []
    var cartArray : [CartItem] = []
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
            self.getCartDataFromApi()
        }
    }
    
    func getCartDataFromApi(){
        cartApi.getCartProducts { dataArray, data in
            self.cartArray = dataArray!
            self.indicatorView.stopAnimating()
            self.view.isUserInteractionEnabled = true
            self.wishlistCollectionview.reloadData()
        }
    }
     
    func uisetUp(){
        cartApi.delegate = self
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

extension FavoraitesVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , CellSubclassWishlistDelegate , CartApiDelegate{
    func cartRequestisDone(message: String) {
        self.view.isUserInteractionEnabled = true
        showALert(message: message)
    }
    
    func cartRequestisFail(message: String) {
        self.view.isUserInteractionEnabled = true
        showALert(message: message)
    }
    
    
    func buttonTapped(cell: FavoraitesCollectionViewCell) {
        guard let indexPath = self.wishlistCollectionview.indexPath(for: cell) else { return }
        self.view.isUserInteractionEnabled = false
        print("Button tapped on row \(indexPath.row)")
        cartApi.addOrRemoveproductFromCart(id: (wishlistArray[indexPath.row].product?.id)!)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wishlistArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoraitesCollectionViewCell.ID, for: indexPath) as! FavoraitesCollectionViewCell
        if cartArray.isEmpty {
            cell.addToCartBtn.setTitle("Add to Cart", for: .normal)
        } else {
            var isInCart = false
            for i in 0..<cartArray.count {
                if wishlistArray[indexPath.row].product?.id == cartArray[i].product?.id {
                    isInCart = true
                    break
                }
            }
            if isInCart {
                cell.addToCartBtn.setTitle("Remove From Cart", for: .normal)
            } else {
                cell.addToCartBtn.setTitle("Add to Cart", for: .normal)
            }
        }
        cell.delegate = self
        cell.viewCell.layer.shadowColor = UIColor.black.cgColor
        cell.viewCell.layer.shadowOpacity = 0.2
        cell.viewCell.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.viewCell.layer.shadowRadius = 5
        cell.productName.text = wishlistArray[indexPath.row].product?.name
        cell.productImage.kf.setImage(with: URL(string: (wishlistArray[indexPath.row].product?.image)!))
        cell.productPrice.text = "\(Float((wishlistArray[indexPath.row].product?.price)!))"
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height / 4)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var numOfSections: Int = 0
            if wishlistArray.count != 0
            {
                //collectionView.separatorStyle = .singleLine
                numOfSections            = 1
                collectionView.backgroundView = nil
            }
            else
            {
                let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
                noDataLabel.text = "No items in wishlist yet"
                noDataLabel.font = .boldSystemFont(ofSize: 20)
                noDataLabel.textColor     = UIColor.lightGray
                noDataLabel.textAlignment = .center
                collectionView.backgroundView  = noDataLabel
                //collectionView.separatorStyle  = .none
            }
            return numOfSections
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProuductDetailsVC()
        vc.id = wishlistArray[indexPath.row].product?.id
         vc.modalPresentationStyle = .fullScreen
         present(vc, animated: true)
    }
}

