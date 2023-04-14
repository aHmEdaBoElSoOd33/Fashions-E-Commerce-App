//
//  ProuductDetailsVC.swift
//  Fashions
//
//  Created by Ahmed on 06/04/2023.
//

import UIKit

class ProuductDetailsVC: UIViewController {
    //MARK: - IBOutlets
    
    @IBOutlet weak var addtoCartButton: UIButton!
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var addtoFavoraitsBtn: UIButton!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    //MARK: - Variables
    
    var currentPage = 0{
        didSet{
            pageControl.currentPage = currentPage
        }
    }
    var cartApi = CartApi()
    var wishlistApi = WishlistApi()
    var productDetailApi = ProductDetailsApi()
    var id : Int?
    var productdetails : ProductDetailsInfo?
    var productImages : [String] = []
    
    lazy var indicatorView : UIActivityIndicatorView = {
        self.activityIndicator(style: .large , center: self.view.center)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
        getProductDetaailsFromApi(id: id!)
    }
    
    //MARK: - Functions
    
    func getProductDetaailsFromApi(id:Int){
        productDetailApi.getProuductDetailsInfo(id: id) { data, massege in
            
            if let data = data{
                self.productdetails = data
                self.pageControl.numberOfPages = (self.productdetails?.images!.count)!
                if (self.productdetails?.in_cart)!{
                    self.addtoCartButton.setTitle("  Remove from cart", for: .normal)
                }else{
                    self.addtoCartButton.setTitle("  Add to cart", for: .normal)
                }
                if (self.productdetails?.in_favorites)!{
                    self.addtoFavoraitsBtn.setImage(UIImage(systemName: "heart.circle.fill"), for: .normal)
                    self.addtoFavoraitsBtn.tintColor = .red
                }else{
                    self.addtoFavoraitsBtn.setImage(UIImage(systemName: "heart.circle.fill"), for: .normal)
                    self.addtoFavoraitsBtn.tintColor = .darkGray
                }
                self.productImages = (data.images)!
                self.productPrice.text = "\((self.productdetails?.price)!)$"
                self.productName.text = self.productdetails?.name
                self.productDescription.text = self.productdetails?.description
                self.productCollectionView.reloadData()
                self.indicatorView.stopAnimating()
                self.view.isUserInteractionEnabled = true
            }else{
                self.addtoFavoraitsBtn.isUserInteractionEnabled = false
                self.indicatorView.stopAnimating()
                self.view.isUserInteractionEnabled = true
                self.showALert(message: massege!)
            }
        }
    }
    
    
    func addtoWishlistApi(id:Int){
        wishlistApi.addproductToFavoriets(id: id)
    }
    
    func uiSetup(){
        cartApi.delegate = self
        view.addSubview(indicatorView)
        indicatorView.startAnimating()
        view.isUserInteractionEnabled = false
        wishlistApi.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        setupCell(collectionview: productCollectionView, ID: BannerCollectionviewCell.ID)
    }
    
    //MARK: - IBActions
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func addToCartBtn(_ sender: UIButton) {
        if sender.titleLabel?.text == "  Add to cart"{
            sender.setTitle("  Remove from cart", for: .normal)
        }else{
            sender.setTitle("  Add to cart", for: .normal)
        }
        cartApi.addOrRemoveproductFromCart(id: (productdetails?.id)!)
    }
    
    @IBAction func shareBtn(_ sender: Any) {
    }
    
    @IBAction func notivicationBtn(_ sender: Any) {
    }
    
    @IBAction func cartBtn(_ sender: Any) {
    }
    
    @IBAction func addToFavoratsBtn(_ sender: UIButton) { 
        if  sender.tintColor == .darkGray {
            sender.setImage(UIImage(systemName: "heart.circle.fill"), for: .normal)
            sender.tintColor = .red
        }else{
            sender.setImage(UIImage(systemName: "heart.circle.fill"), for: .normal)
            sender.tintColor = .darkGray
        }
        addtoWishlistApi(id: id!)
    }
    
    
}


extension ProuductDetailsVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , WishlistApiDelegate  , CartApiDelegate{
    func cartRequestisDone(message: String) {
        showALert(message: message)
    }
    
    func cartRequestisFail(message: String) {
        showALert(message: message)
    }
    
    func addtoWishlistIsDone(message: String) {
        showALert(message: message)
    }
    
    func addtoWishlistIsFail(message: String) {
        showALert(message: message)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionviewCell.ID, for: indexPath) as! BannerCollectionviewCell
        cell.bannerImage.kf.setImage(with: URL(string: productImages[indexPath.row]), placeholder: UIImage(named: "Group 5"))
        return cell
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height  )
    }
}
