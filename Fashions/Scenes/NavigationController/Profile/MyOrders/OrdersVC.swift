//
//  OrdersVC.swift
//  Fashions
//
//  Created by Ahmed on 14/04/2023.
//

import UIKit

class OrdersVC: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var ordersCollectionView: UICollectionView!
    @IBOutlet weak var newBtn: UIButton!
    
    @IBOutlet weak var cancelledBtn: UIButton!
    
    
    //MARK: - Variables
    var status : String?
    var orderApi = OrdersApi()
    var lastSender = 3
    var ordersArray : [OrderModelDataDetails] = []
    var fillteredOrdersArray : [OrderModelDataDetails] = []
    var indecatorView : UIActivityIndicatorView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        uiSetup()
        getOrdersDataFromApi()
    }
    //MARK: - Functions
    func uiSetup(){
        status = "new"
        cancelledBtn.layer.borderColor = UIColor.lightGray.cgColor
        cancelledBtn.layer.borderWidth = 0.5
        newBtn.isSelected = true 
        newBtn.backgroundColor = .black
        newBtn.layer.borderWidth = 0
        
        ordersCollectionView.isUserInteractionEnabled = false
        indecatorView = activityIndicator(style: .large, center: self.view.center)
        setupCell(collectionview: ordersCollectionView, ID: OrderCollectionViewCell.ID)
        indecatorView?.startAnimating()
        self.view.addSubview(indecatorView!)
        ordersCollectionView.delegate = self
        ordersCollectionView.dataSource = self
    }
    
    func getOrdersDataFromApi(){
        orderApi.getOrders { data in
            self.ordersArray = data
            self.fillteredOrdersArray = self.ordersArray
            self.fillteredOrdersArray = self.ordersArray.filter{$0.status == "New"}
            self.ordersCollectionView.reloadData()
            self.indecatorView?.stopAnimating()
            self.ordersCollectionView.isUserInteractionEnabled = true
        }
    }
    
    
    //MARK: - IBActions
    @IBAction func switchCollectionNewAndCancelBtns(_ sender: UIButton) {
        if let lastPressedBtn:UIButton = view.viewWithTag(lastSender) as? UIButton{
            lastPressedBtn.isSelected = false
            lastPressedBtn.titleLabel?.textColor = UIColor.lightGray
            lastPressedBtn.backgroundColor = .clear
            lastPressedBtn.layer.borderColor = UIColor.lightGray.cgColor
            lastPressedBtn.layer.borderWidth = 0.5
        }
        switch sender.tag{
        case 3:
            sender.isSelected = true
            sender.titleLabel?.textColor = UIColor.white
            sender.backgroundColor = .black
            sender.layer.borderWidth = 0
            fillteredOrdersArray = ordersArray.filter{$0.status == "New"}
            status = "new"
            ordersCollectionView.reloadData()
        default:
            sender.isSelected = true
            sender.titleLabel?.textColor = UIColor.white
            sender.backgroundColor = .black
            sender.layer.borderWidth = 0
            fillteredOrdersArray = ordersArray.filter{$0.status == "Cancelled"}
            status = "cancelled"
            ordersCollectionView.reloadData()
        }
        lastSender = sender.tag
        print(lastSender)
    }
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
}
    

extension OrdersVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fillteredOrdersArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var numOfSections: Int = 0
            if fillteredOrdersArray.count != 0
            {
                //collectionView.separatorStyle = .singleLine
                numOfSections            = 1
                collectionView.backgroundView = nil
            }
            else
            {
                let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
                noDataLabel.text = "There are no \(status!) orders"
                noDataLabel.font = .boldSystemFont(ofSize: 20)
                noDataLabel.textColor     = UIColor.lightGray
                noDataLabel.textAlignment = .center
                collectionView.backgroundView  = noDataLabel
                //collectionView.separatorStyle  = .none
            }
            return numOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderCollectionViewCell.ID, for: indexPath) as! OrderCollectionViewCell
        
        cell.orderState.text = fillteredOrdersArray[indexPath.row].status
        cell.dateLbl.text = fillteredOrdersArray[indexPath.row].date
        cell.totalcostLbl.text = "\(Float(fillteredOrdersArray[indexPath.row].total!))"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height / 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = OrderDetailsVC()
        vc.id = fillteredOrdersArray[indexPath.row].id
        vc.status = fillteredOrdersArray[indexPath.row].status
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}
