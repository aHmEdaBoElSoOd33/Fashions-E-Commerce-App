//
//  PersonalDetailsVC.swift
//  Fashions
//
//  Created by Ahmed on 14/04/2023.
//

import UIKit

class PersonalDetailsVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
//MARK: - IBOutlets
    
    @IBOutlet weak var saveChangesBtn: UIButton!
    @IBOutlet weak var editProfileBtn: UIButton!
    @IBOutlet weak var editPhoto: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNametxtField: UITextField!
    @IBOutlet weak var EmailtxtField: UITextField!
    @IBOutlet weak var phoneTxtField: UITextField!
   
    //MARK: - Variables
    var logoutApi = RegisterApi()
    var homeApi = HomeApi()
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoutApi.logOutDelegate = self
        uiSetup()
        picker.delegate = self
        // Do any additional setup after loading the view.
    }
  
    //MARK: - Functions
    
    func getProfileData(){
        homeApi.getUserProfileData()
    }
     
    func uiSetup(){
        if UserDefaults.standard.string(forKey: "userName") == nil{
            homeApi.delegate = self
            getProfileData()
        }else{
            phoneTxtField.text = UserDefaults.standard.string(forKey: "userPhone")
            userNametxtField.text = UserDefaults.standard.string(forKey: "userName")
            EmailtxtField.text = UserDefaults.standard.string(forKey: "userEmail")
            userImage.kf.setImage(with: URL(string: UserDefaults.standard.string(forKey: "userImage")!))
        }
        homeApi.profileDelegate = self
        editPhoto.isHidden = true
        saveChangesBtn.isHidden = true
    }
    
    //MARK: - IBActions
    
    
    
    
    
    @IBAction func editProfileImage(_ sender: Any) {
        
        editPhoto.isHidden = false
        saveChangesBtn.isHidden = false
    }
    @IBAction func selectImageButtonTapped(_ sender: UIButton) {
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    @IBAction func logOutBtn(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "userToken")
        UserDefaults.standard.set(nil, forKey: "userPhone")
        UserDefaults.standard.set(nil, forKey: "userName")
        UserDefaults.standard.set(nil, forKey: "userEmail")
        UserDefaults.standard.set(nil, forKey: "userImage")
        logoutApi.LogoutfromDataBase()
        let vc = SecondSplashVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func saveChangesBtn(_ sender: Any) {
        guard let image = userImage.image,
                      let imageData = image.jpegData(compressionQuality: 1.0) else {
                    return
                }
        print(userNametxtField.text!)
        homeApi.updateProfile(name: userNametxtField.text!, image: imageData, email: EmailtxtField.text!, phone: phoneTxtField.text!)
        
    }
     
}


extension PersonalDetailsVC : LogOutApiDelegate, HomeApiDelegate , updateProfileDelegate{
  
    func updateprofileIsDone(message: String) {
        showALert(message: message)
    }
    
    func updateprofileIsFail(message:  String) {
        showALert(message: message)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         dismiss(animated: true)

         if let image = info[.originalImage] as? UIImage {
             userImage.image = image
         }
     }

     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         dismiss(animated: true)
     }
     
    
    
    
    func profireDataIsDone(Data: DataClass) {
        userNametxtField.text = Data.name
        EmailtxtField.text = Data.email
        userImage.kf.setImage(with: URL(string: Data.image!))
    }
    
    func profileDataIsFail(masssage: String) {
        showALert(message: masssage)
    }
    
    
    func logoutIsDone(massage: String) {
        print(massage)
        
    }
    
    func logoutIsFail(massage: String) {
        print(massage)
    }
}
