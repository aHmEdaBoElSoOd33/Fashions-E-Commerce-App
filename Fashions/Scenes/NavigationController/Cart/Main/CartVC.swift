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
    
    @IBOutlet weak var EmptyCartLbl: UILabel!
    @IBOutlet weak var addAddressBtn: UIButton!
    @IBOutlet weak var addressCollectionView: UICollectionView!
    @IBOutlet weak var numberOfItems: UILabel!
    @IBOutlet weak var CartBtn: UIButton!
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var totalPrice: UILabel!
    
    //MARK: - Variables
    
    static var ID = String(describing: CartVC.self)
    var arr = [1,2,3,4,5]
    var cartApi = CartApi()
    var orderApi = OrdersApi()
    var addressApi = AddressApi()
    var addressArray : [AddressDetailsData] = []
    var cartArray : [CartItem] = []
    lazy var indicatorView : UIActivityIndicatorView = {
        self.activityIndicator(style: .large, center: self.view.center)
    }()
    lazy var indicatorView2 : UIActivityIndicatorView = {
        self.activityIndicator(style: .large, center: self.view.center)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        uiSetup()
        getCartDataFromApi()
    }
    
    //MARK: - Functions
    
    func uiSetup(){
        EmptyCartLbl.isHidden = true
        orderApi.delegate = self
        cartApi.delegate = self
        view.addSubview(indicatorView)
        indicatorView.startAnimating()
        view.addSubview(indicatorView2)
        indicatorView2.startAnimating()
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
            if self.cartArray.isEmpty {
                self.EmptyCartLbl.isHidden = false
            }else{
                self.EmptyCartLbl.isHidden = true
            }
            self.numberOfItems.text = "Total(\((data?.cart_items?.count)!) item)"
            self.totalPrice.text = "\(Float((data?.total)!))$"
            self.getAddressdataFromApi()
            self.cartTableView.reloadData()
            self.indicatorView.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    
    func getAddressdataFromApi(){
        addressApi.getAddressData { data in
            self.addressArray = data
            if self.addressArray.count == 1 {
                self.addAddressBtn.isHidden = true
            }else{
                self.addAddressBtn.isHidden = false
            }
            self.indicatorView2.stopAnimating()
            self.addressCollectionView.reloadData()
        }
    }
    
    //MARK: - IBActions
    
    @IBAction func checkOutBtn(_ sender: Any) {
        if addressArray.isEmpty{
            showALert(message: "Add Address")
        }else if cartArray.isEmpty{
           showALert(message: "Cart is empty add products")
        }else{
            orderApi.AddOrder(address_id: String(addressArray[0].id!), promo_code_id: nil)
        }
    }
    
    
    @IBAction func addAddressBtn(_ sender: Any) {
        let vc = AddressVC()
        vc.state = "add"
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
}



extension CartVC : UITableViewDelegate , UITableViewDataSource , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , CartApiDelegate , AddOrderDelegate {
    func AddorderIsDone(message: String) {
        showALert(message: message)
    }
    
    func AddorderIsFail(message: String) {
        showALert(message: message)
    }
    
    func cartRequestisDone(message: String) {
        showALert(message: message)
    }
    
    func cartRequestisFail(message: String) {
        showALert(message: message)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addressArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddressCollectionViewCell.ID, for: indexPath) as! AddressCollectionViewCell
        
        cell.addressNameLbl.text = addressArray[indexPath.row].name
        cell.countryLbl.text = addressArray[indexPath.row].city
        
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
        cell.selectionStyle = .none
        cell.cellContent.layer.shadowColor = UIColor.black.cgColor
        cell.cellContent.layer.shadowOpacity = 0.1
        cell.cellContent.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.cellContent.layer.shadowRadius = 5
        cell.productPrice.text = "\(Float((cartArray[indexPath.row].product?.price)!))$"
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
            if self.cartArray.isEmpty {
                self.EmptyCartLbl.isHidden = false
            }else{
                self.EmptyCartLbl.isHidden = true
            }
        }
        deleteAction.image = UIImage(named: "delete")
        deleteAction.backgroundColor = .black 
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

//    func numberOfSections(in tableView: UITableView) -> Int {
//        var numOfSections: Int = 0
//            if cartArray.count != 0
//            {
//                //collectionView.separatorStyle = .singleLine
//                numOfSections            = 1
//                tableView.backgroundView = nil
//            }
//            else
//            {
//                let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
//                noDataLabel.text = "No items in cart yet"
//                noDataLabel.font = .boldSystemFont(ofSize: 20)
//                noDataLabel.textColor     = UIColor.lightGray
//                noDataLabel.textAlignment = .center
//                tableView.backgroundView  = noDataLabel
//                //collectionView.separatorStyle  = .none
//            }
//            return numOfSections
//    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var numOfSections: Int = 0
            if addressArray.count != 0
            {
                //collectionView.separatorStyle = .singleLine
                numOfSections            = 1
                collectionView.backgroundView = nil
            }
            else
            {
                let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
                noDataLabel.text = "No Address , Add one"
                noDataLabel.font = .boldSystemFont(ofSize: 20)
                noDataLabel.textColor     = UIColor.lightGray
                noDataLabel.textAlignment = .center
                collectionView.backgroundView  = noDataLabel
                //collectionView.separatorStyle  = .none
            }
            return numOfSections
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hi")
        let vc = ProuductDetailsVC()
        vc.id = cartArray[indexPath.row].product?.id
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = AddressVC()
        vc.state = "update"
        vc.address = addressArray[indexPath.row]
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}
