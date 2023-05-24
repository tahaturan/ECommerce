//
//  UserAddressVC.swift
//  ECommerce
//
//  Created by Taha Turan on 24.05.2023.
//

import UIKit
import Firebase

class UserAddressVC: UIViewController {
    
    @IBOutlet weak var contryLabel: UILabel!
    
    @IBOutlet weak var countryTextField: UITextField!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      textFieldPlaceHolder()
    }
    

    @IBAction func saveButtonClicked(_ sender: Any) {
        
        saveAddress()
    }
    

}




//MARK: -fireBaseVeri adres kaydetme
extension UserAddressVC{
    func saveAddress()  {
        
        let fireStore = Firestore.firestore()
        
        fireStore.collection("UserInfo").whereField("userid", isEqualTo: UserSingleton.sharedUserInfo.userid).addSnapshotListener { snapshot , error in
            
            if error != nil {
                ApplicationConstants.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "Error", viewController: self)
            }else {
                
                if snapshot?.isEmpty == false && snapshot != nil {
                    
                    for document in snapshot!.documents{
                        
                        let documentId = document.documentID
                        
                        if let country = self.countryTextField.text {
                            if let city = self.cityTextField.text {
                                if let address = self.addressTextField.text {
                                    
                                    let userAddressDict = ["userCountry" : country , "userCity": city , "userAddress":address]
                                    
                                    fireStore.collection("UserInfo").document(documentId).setData(userAddressDict, merge: true) { error in
                                        if error != nil {
                                            ApplicationConstants.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "Error", viewController: self)
                                        }else {
                                            ApplicationConstants.makeAlert(title: "Basarili", message: "Adres kaydiniz yapilmistir", viewController: self)
                                            
                                            UserSingleton.sharedUserInfo.userAddress = address
                                            UserSingleton.sharedUserInfo.userCity = city
                                            UserSingleton.sharedUserInfo.userCountry = country
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


//MARK: - Textfield Design
extension UserAddressVC{
    
    func textFieldPlaceHolder()  {
        
        countryTextField.placeholder = UserSingleton.sharedUserInfo.userCountry
        cityTextField.placeholder = UserSingleton.sharedUserInfo.userCity
        addressTextField.placeholder = UserSingleton.sharedUserInfo.userAddress
        
    }
    
    
}
