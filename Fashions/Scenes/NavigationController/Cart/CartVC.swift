//
//  CartVC.swift
//  Fashions
//
//  Created by Ahmed on 03/04/2023.
//

import UIKit

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
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
    }

    //MARK: - Functions
    
    func uiSetup(){
        
        cartTableView.dataSource = self
        cartTableView.delegate = self
        addressCollectionView.delegate = self
        addressCollectionView.dataSource = self
        cartTableView.register(UINib(nibName: CartTableViewCell.ID, bundle: nil), forCellReuseIdentifier: CartTableViewCell.ID)
        setupCell(collectionview: addressCollectionView, ID: AddressCollectionViewCell.ID)
        
        
    }
    
    
    
    
    
    
    //MARK: - IBActions
    
    @IBAction func checkOutBtn(_ sender: Any) {
    }
    
}



extension CartVC : UITableViewDelegate , UITableViewDataSource , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
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
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.ID, for: indexPath) as! CartTableViewCell
        cell.cellContent.layer.shadowColor = UIColor.black.cgColor
        cell.cellContent.layer.shadowOpacity = 0.1
        cell.cellContent.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.cellContent.layer.shadowRadius = 5
        return cell
    }
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") { action, view, completionHandler in
            self.arr.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            completionHandler(true)
        }
        
        deleteAction.image = UIImage(named: "delete")
        deleteAction.backgroundColor = .black
        
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
    
    
    
}
