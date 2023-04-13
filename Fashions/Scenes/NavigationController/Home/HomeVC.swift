//
//  HomeVC.swift
//  Fashions
//
//  Created by Ahmed on 03/04/2023.
//

import UIKit
import Kingfisher

protocol Navigation {
    func navigate()
}



class HomeVC: UIViewController{
 
//MARK: - IBOutlets
    
 
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var naewArrivalCollectionView: UICollectionView!
   //MARK: -  Variables
    
    var delegate : Navigation?
    var wishlistApi = WishlistApi()
    var bannerArray : [Banner] = []
    var productsArray : [Product] = []
    var homeApi = HomeApi()
    lazy var indicatorView : UIActivityIndicatorView = { self.activityIndicator(style: .large,center: self.view.center)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
           
    }
    //MARK: -  Functions
    
    override func viewWillAppear(_ animated: Bool) {
        uiSetup()
        getHomeDataFromApi()
        homeApi.delegate = self
    }
    
    func uiSetup(){
        view.isUserInteractionEnabled = false
        self.view.addSubview(indicatorView) 
        indicatorView.startAnimating()
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        naewArrivalCollectionView.delegate = self
        naewArrivalCollectionView.dataSource = self
        wishlistApi.delegate = self
        setupCell(collectionview: bannerCollectionView, ID: BannerCollectionviewCell.ID)
        setupCell(collectionview: naewArrivalCollectionView, ID: NewArrivalCollectionViewCell.ID)
    }
    
    func getHomeDataFromApi(){
        homeApi.getUserProfileData()
        homeApi.getHomeData { products, banners, error in
            self.productsArray = products!
            self.bannerArray = banners!
            self.indicatorView.stopAnimating()
            self.view.isUserInteractionEnabled = true
            self.bannerCollectionView.reloadData()
            self.naewArrivalCollectionView.reloadData()
        }
    }
    //MARK: - IBActions
    @IBAction func showAllBtn(_ sender: Any) {
        let vc = CategoriesProductsVC()
        vc.titleName = "New Arrival" 
        vc.fromNewArrival = true
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func categoriesBtn(_ sender: Any) {
        let vc = CategoriesVC()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        present(vc, animated: true)
    }
 
}


extension HomeVC : UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, HomeApiDelegate , CellSubclassProductDelegate , WishlistApiDelegate {
    
    func addtoWishlistIsDone(message: String) {
        self.view.isUserInteractionEnabled = true
        showALert(message: message)
    }
    
    func addtoWishlistIsFail(message: String) {
        self.view.isUserInteractionEnabled = true
        showALert(message: message)
    }
    
    func buttonTapped(cell: NewArrivalCollectionViewCell) {
        guard let indexPath = self.naewArrivalCollectionView.indexPath(for: cell) else { return }
        
        if cell.favBtn.tintColor == .black {
            cell.favBtn.setImage(UIImage(systemName: "heart.circle.fill"), for: .normal)
            cell.favBtn.tintColor = .red
        }else{
            cell.favBtn.setImage(UIImage(systemName: "heart.circle.fill"), for: .normal)
            cell.favBtn.tintColor = .black
        }
        self.view.isUserInteractionEnabled = false
        print("Button tapped on row \(indexPath.row)")
        
        wishlistApi.addproductToFavoriets(id: productsArray[indexPath.row].id!)
    }
    
  
    func profireDataIsDone(Data: DataClass) {
        userImage.kf.setImage(with: URL(string: Data.image!))
    }
    
    func profileDataIsFail(masssage: String) {
        print(masssage)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case naewArrivalCollectionView :
            return productsArray.count
        default:
            return bannerArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView{
        case naewArrivalCollectionView :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewArrivalCollectionViewCell.ID , for: indexPath) as! NewArrivalCollectionViewCell
            cell.delegate = self
            
            if productsArray[indexPath.row].in_favorites! {
                cell.favBtn.setImage(UIImage(systemName:  "heart.circle.fill"), for: .normal)
                cell.favBtn.tintColor = .red
            }else{
                cell.favBtn.setImage(UIImage(systemName:  "heart.circle.fill"), for: .normal)
                cell.favBtn.tintColor = .black
            }
            
            cell.productImage.kf.setImage(with: URL(string: productsArray[indexPath.row].image!), placeholder: UIImage(named: "Group 5"))
            cell.productName.text = productsArray[indexPath.row].name
            cell.productPrice.text = "\((productsArray[indexPath.row].price)!)"
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionviewCell.ID , for: indexPath) as! BannerCollectionviewCell
            
            cell.bannerImage.kf.setImage(with:  URL(string: bannerArray[indexPath.row].image!), placeholder: UIImage(named: "Group 5") )
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView{
        case naewArrivalCollectionView:
            return CGSize(width: naewArrivalCollectionView.bounds.width  / 2 - 10 , height: naewArrivalCollectionView.bounds.height)
        default:
            return CGSize(width: bannerCollectionView.bounds.width / 1.2 , height: bannerCollectionView.bounds.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView{
        case naewArrivalCollectionView:
           let vc = ProuductDetailsVC()
            vc.id = productsArray[indexPath.row].id
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        default:
            break
        }
    }
}

