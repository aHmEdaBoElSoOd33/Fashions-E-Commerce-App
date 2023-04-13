//
//  CartVC.swift
//  Fashions
//
//  Created by Ahmed on 03/04/2023.
//

import UIKit
import Kingfisher


class CartVC: UIViewController {
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var addressCollectionView: UICollectionView!
    @IBOutlet weak var numberOfItems: UILabel!
    @IBOutlet weak var CartBtn: UIButton!
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var totalPrice: UILabel!
    
    //MARK: - Variables
    
    static var ID = String(describing: CartVC.self)
    var arr = [1,2,3,4,5]
    var cartApi = CartApi()
    var cartArray : [CartItem] = []
    lazy var indicatorView : UIActivityIndicatorView = {
        self.activityIndicator(style: .large, center: self.view.center)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
        getCartDataFromApi()
    }

    //MARK: - Functions
    
    func uiSetup(){
        cartApi.delegate = self
        view.addSubview(indicatorView)
        indicatorView.startAnimating()
        view.isUserInteractionEnabled = false
        cartTableView.dataSource = self
        cartTableView.delegate = self
        addressCollectionView.delegate = self
        addressCollectionView.dataSource = self
        cartTableView.register(UINib(nibName: CartTableViewCell.ID, bundle: nil), forCellReuseIdentifier: CartTableViewCell.ID)
        setupCell(collectionview: addressCollectionView, ID: AddressCollectionViewCell.ID)
    }
    
    func getCartDataFromApi(){
        cartApi.getCartProducts { dataArray, data in
            self.cartArray = dataArray!
            self.numberOfItems.text = "Total(\((data?.cart_items?.count)!) item)"
            self.totalPrice.text = "\((data?.total)!)$"
            self.cartTableView.reloadData()
            self.indicatorView.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    
    
    
    //MARK: - IBActions
    
    @IBAction func checkOutBtn(_ sender: Any) {
    }
    
}



extension CartVC : UITableViewDelegate , UITableViewDataSource , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , CartApiDelegate{
    func cartRequestisDone(message: String) {
        showALert(message: message)
    }
    
    func cartRequestisFail(message: String) {
        showALert(message: message)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddressCollectionViewCell.ID, for: indexPath) as! AddressCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 80)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.ID, for: indexPath) as! CartTableViewCell
        cell.cellContent.layer.shadowColor = UIColor.black.cgColor
        cell.cellContent.layer.shadowOpacity = 0.1
        cell.cellContent.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.cellContent.layer.shadowRadius = 5
        cell.productPrice.text = "\((cartArray[indexPath.row].product?.price)!)$"
        cell.productImage.kf.setImage(with: URL(string: (cartArray[indexPath.row].product?.image)!))
        cell.productName.text = cartArray[indexPath.row].product?.name
        
        return cell
    }
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") { action, view, completionHandler in
            self.cartApi.addOrRemoveproductFromCart(id: (self.cartArray[indexPath.row].product?.id)!)
            self.cartArray.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            completionHandler(true)
        }
        
        deleteAction.image = UIImage(named: "delete")
        deleteAction.backgroundColor = .black
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
     
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hi")
        let vc = ProuductDetailsVC()
        vc.id = cartArray[indexPath.row].product?.id
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}
