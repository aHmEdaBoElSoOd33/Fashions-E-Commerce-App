//
//  CategoriesProductsVC.swift
//  Fashions
//
//  Created by Ahmed on 06/04/2023.
//

import UIKit

class CategoriesProductsVC: UIViewController {
  
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    //MARK: - Variables
    var wishlistApi = WishlistApi()
    var homeApi = HomeApi()
    var dataArray : [Product] = []
    var categoriesProductsArray : [categoryDetails] = []
    var id : Int?
    var titleName : String?
    var categoriesApi = CategoriesApi()
    var fromNewArrival = true
    
    lazy var indicatoView : UIActivityIndicatorView = {
        self.activityIndicator(style: .large, center: self.view.center)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        uiSetup()
        if !fromNewArrival{
            getCategoriesProductFromApi(id: id!)
        }else{
            getNewArrivalDataFromApi()
        }
    }
    //MARK: -  Functions
    
    func uiSetup(){
        wishlistApi.delegate = self
        view.addSubview(indicatoView)
        self.view.isUserInteractionEnabled = false
        indicatoView.startAnimating()
        titleLbl.text = titleName
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        
        setupCell(collectionview: productsCollectionView, ID: NewArrivalCollectionViewCell.ID)
    }
    
    func getNewArrivalDataFromApi(){
        homeApi.getHomeData { products, banner, error in
            self.dataArray = products!
            self.productsCollectionView.reloadData()
            self.indicatoView.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    
    
    func getCategoriesProductFromApi(id:Int){
        categoriesApi.getCategoriesDetails(id: id) { data in
            self.categoriesProductsArray = data
            self.productsCollectionView.reloadData()
            self.indicatoView.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    
    //MARK: - IBActions
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
}


extension CategoriesProductsVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , CellSubclassProductDelegate , WishlistApiDelegate{
    func addtoWishlistIsDone(message: String) {
        self.view.isUserInteractionEnabled = true
        showALert(message: message)
        
    }
    
    func addtoWishlistIsFail(message: String) {
        self.view.isUserInteractionEnabled = true
        showALert(message: message)
        
    }
    
    
    func buttonTapped(cell: NewArrivalCollectionViewCell) {
        guard let indexPath = self.productsCollectionView.indexPath(for: cell) else { return }
        
        if cell.favBtn.tintColor == .black {
            cell.favBtn.setImage(UIImage(systemName: "heart.circle.fill"), for: .normal)
            cell.favBtn.tintColor = .red
        }else{
            cell.favBtn.setImage(UIImage(systemName: "heart.circle.fill"), for: .normal)
            cell.favBtn.tintColor = .black
        }
        self.view.isUserInteractionEnabled = false
        print("Button tapped on row \(indexPath.row)")
        
        if dataArray.count == 0{
            wishlistApi.addproductToFavoriets(id: categoriesProductsArray[indexPath.row].id!)
        }else{
            wishlistApi.addproductToFavoriets(id: dataArray[indexPath.row].id!)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        if !fromNewArrival{
            return categoriesProductsArray.count
        }else{
            return dataArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewArrivalCollectionViewCell.ID , for: indexPath) as! NewArrivalCollectionViewCell
        
        if !fromNewArrival{
            cell.productImage.kf.setImage(with: URL(string: categoriesProductsArray[indexPath.row].image!), placeholder: UIImage(named: "Group 5"))
            cell.productName.text = categoriesProductsArray[indexPath.row].name
            cell.productPrice.text = "\((categoriesProductsArray[indexPath.row].price)!)"
            cell.delegate = self
            
            if categoriesProductsArray[indexPath.row].in_favorites {
                cell.favBtn.setImage(UIImage(systemName:  "heart.circle.fill"), for: .normal)
                cell.favBtn.tintColor = .red
            }else{
                cell.favBtn.setImage(UIImage(systemName:  "heart.circle.fill"), for: .normal)
                cell.favBtn.tintColor = .black
            }
            return cell
        }else{
            cell.delegate = self
            
            if dataArray[indexPath.row].in_favorites! {
                cell.favBtn.setImage(UIImage(systemName:  "heart.circle.fill"), for: .normal)
                cell.favBtn.tintColor = .red
            }else{
                cell.favBtn.setImage(UIImage(systemName:  "heart.circle.fill"), for: .normal)
                cell.favBtn.tintColor = .black
            }
            cell.productImage.kf.setImage(with: URL(string: dataArray[indexPath.row].image!), placeholder: UIImage(named: "Group 5"))
            cell.productName.text = dataArray[indexPath.row].name
            cell.productPrice.text = "\((dataArray[indexPath.row].price)!)"
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: productsCollectionView.bounds.width / 2 - 10 , height: productsCollectionView.bounds.height / 2.5)
        }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !fromNewArrival{
            let vc = ProuductDetailsVC()
             vc.id = categoriesProductsArray[indexPath.row].id
             vc.modalPresentationStyle = .fullScreen
             present(vc, animated: true)
        }else{
            let vc = ProuductDetailsVC()
             vc.id = dataArray[indexPath.row].id
             vc.modalPresentationStyle = .fullScreen
             present(vc, animated: true) 
        }
        
    }
}
    
 
