//
//  ShippingAddressVC.swift
//  Fashions
//
//  Created by Ahmed on 14/04/2023.
//

import UIKit

class ShippingAddressVC: UIViewController {
//MARK: - IBOutlets
    
    @IBOutlet weak var addressView: UIView!
    
    @IBOutlet weak var addressName: UILabel!
    
    @IBOutlet weak var cityLbl: UILabel!
    
    @IBOutlet weak var regionLbl: UILabel!
    
    @IBOutlet weak var detailsLbl: UILabel!
    
    //MARK: - Variables
    var addressApi = AddressApi()
    var addressArray : [AddressDetailsData] = []
    lazy var indicatorView : UIActivityIndicatorView = {
        self.activityIndicator(style: .large, center: self.view.center)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiSetup()
        getAddressdataFromApi()
    }
    
    
    //MARK: - Functions
    
    func uiSetup(){
        view.addSubview(indicatorView)
        self.indicatorView.startAnimating()
        addressView.layer.shadowColor = UIColor.black.cgColor
        addressView.layer.shadowOpacity = 0.1
        addressView.layer.shadowOffset = CGSize(width: 0, height: 20)
        addressView.layer.shadowRadius = 20
    }
    
    
    
    func getAddressdataFromApi(){
        addressApi.getAddressData { data in
            self.addressArray = data
            if self.addressArray.isEmpty{
                self.indicatorView.stopAnimating()
                self.showALert(message: "There are no addresses")
            }else{
                self.addressName.text = self.addressArray[0].name
                self.cityLbl.text = self.addressArray[0].city
                self.regionLbl.text = self.addressArray[0].region
                self.detailsLbl.text = self.addressArray[0].details
                self.indicatorView.stopAnimating()
            }
        }
    }
    
     
    //MARK: - IBActions
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
}
