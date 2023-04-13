//
//  OnBoardingVC.swift
//  Fashions
//
//  Created by Ahmed on 01/04/2023.
//

import UIKit

class OnBoardingVC: UIViewController {
    //MARK: - IBOutlets
    
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pagecontrol: UIPageControl!
    
    
    //MARK: - Variables
    
    static let ID = String(describing: OnBoardingVC.self)
    var slideTitle = ["20% Discount New Arrival Product" , "Take Advantage Of The Offer Shopping " , "All Types Offers Within Your Reach"]
    var slideImage = ["onboard1" , "onboard2" , "onboard3"]
    var slider : [Slide] = []
    var currentPage = 0{
        didSet{
            pagecontrol.currentPage = currentPage
            if pagecontrol.currentPage == 0 {
                pagecontrol.setIndicatorImage(UIImage(named: "Ellipse 2"), forPage: 1)
                pagecontrol.setIndicatorImage(UIImage(named: "Ellipse 2"), forPage: 2)
                pagecontrol.setIndicatorImage(UIImage(named: "Rectangle 2"), forPage: currentPage)
            }else if currentPage == 1{
                pagecontrol.setIndicatorImage(UIImage(named: "Ellipse 2"), forPage: 0)
                pagecontrol.setIndicatorImage(UIImage(named: "Ellipse 2"), forPage: 2)
                pagecontrol.setIndicatorImage(UIImage(named: "Rectangle 2"), forPage: currentPage)
            }else{
                pagecontrol.setIndicatorImage(UIImage(named: "Ellipse 2"), forPage: 0)
                pagecontrol.setIndicatorImage(UIImage(named: "Ellipse 2"), forPage: 1)
                pagecontrol.setIndicatorImage(UIImage(named: "Rectangle 2"), forPage: currentPage)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        uiSetup()
        
    }
    
    
    
    func uiSetup(){
        pagecontrol.setIndicatorImage(UIImage(named: "Rectangle 2"), forPage: currentPage)
        for i in 0...slideImage.count - 1{
            slider.append(Slide(title: slideTitle[i], image: slideImage[i]))
        }
        sliderCollectionView.dataSource = self
        sliderCollectionView.delegate = self
        
        setupCell(collectionview: sliderCollectionView, ID: OnboardingCell.ID)
    }
 
    @IBAction func nextBtn(_ sender: Any) {
        if currentPage == slider.count - 1 {
            let vc = SecondSplashVC()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            UserDefaults.standard.setValue(true, forKey: "OnBoardingShowed")
        }else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            sliderCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}


extension OnBoardingVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slider.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.ID, for: indexPath) as! OnboardingCell
        cell.siderImage.image = UIImage(named: slider[indexPath.row].image)
        cell.sliderTitle.text = slider[indexPath.row].title
         
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
}
