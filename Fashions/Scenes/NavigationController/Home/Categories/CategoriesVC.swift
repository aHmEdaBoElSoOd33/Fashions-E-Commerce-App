//
//  CategoriesVC.swift
//  Fashions
//
//  Created by Ahmed on 04/04/2023.
//

import UIKit

class CategoriesVC: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    
    //MARK: - Variables
    
    var categoriesApi = CategoriesApi()
    var categoriesArray : [Datum] = []
    var categoriesIDs : [Int] = []
    lazy var indicatorView : UIActivityIndicatorView = { self.activityIndicator(style: .large,center: self.view.center)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
        getCategoriesDataFromApi()
    }
 //MARK: - Functions
    func uiSetup(){
        view.isUserInteractionEnabled = false
        self.view.addSubview(indicatorView)
        indicatorView.startAnimating()
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        setupCell(collectionview: categoriesCollectionView, ID: CategoriesCollectionViewCell.ID)
    }
   
    func getCategoriesDataFromApi(){
        categoriesApi.getCategories { data, error in
            self.categoriesArray = data!
            self.categoriesCollectionView.reloadData()
            self.indicatorView.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
    //MARK: - IBActions
     
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
}


extension CategoriesVC : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.ID, for: indexPath) as! CategoriesCollectionViewCell
        
        if indexPath.row % 2 == 0 {
            cell.leadingconstrainLable.constant = collectionView.frame.width / 1.5
            cell.trailingConstrainImage.constant = 0
        }else{
            cell.leadingconstrainLable.constant = 40
            
            cell.trailingConstrainImage.constant = collectionView.frame.width / 3
        }
        
        cell.categoryImage.kf.setImage(with: URL(string: categoriesArray[indexPath.row].image!), placeholder: UIImage(named: "Group 5"))
        cell.categoryName.text = categoriesArray[indexPath.row].name
        return cell
    }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: categoriesCollectionView.bounds.width, height: categoriesCollectionView.bounds.height / 6 + 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CategoriesProductsVC()
        vc.fromNewArrival = false
        vc.titleName = categoriesArray[indexPath.row].name
        vc.id = categoriesArray[indexPath.row].id
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}
