//
//  DetailsVC.swift
//  ECommerce
//
//  Created by Taha Turan on 17.05.2023.
//

import UIKit
import Firebase

class DetailsVC: UIViewController {
    
    var product : ProductViewModel! = nil
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewDesign()

        
    }
    

    @IBAction func addBasketButtonClicked(_ sender: Any) {
        addBasket()
    }
    

}



//MARK: - design
extension DetailsVC {
    
    func viewDesign()  {
        
        if let product = product {
            imageView.sd_setImage(with: URL(string: product.image))
            titleLabel.text = product.title
            descriptionLabel.text = product.description
            priceLabel.text = "\(product.price)$"
        }
        
    }
}




//MARK: - Add Basket -- Sepete ekleme ve firebase e kaydetme islemleri
extension DetailsVC{
    func addBasket()  {
        
        let fireStore = Firestore.firestore()
        
        let productDict = ["id":product.id ,"title":product.title ,"price":product.price ,"image":product.image] as [String : Any]
        
        fireStore.collection("Basket").whereField("userid", isEqualTo: UserSingleton.sharedUserInfo.userid).getDocuments { snapshot , error in
            if error != nil {
                ApplicationConstants.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "Error!", viewController: self)
            }else{
                if snapshot?.isEmpty == false && snapshot != nil {
                    for document in snapshot!.documents{
                        
                        let documentId = document.documentID
                        
                        if var productArray = document.get("productArray") as? [[String : Any]]{
                            productArray.append(productDict)
                            
                            let additionalDictionary = ["productArray" : productArray] as [String : Any]
                            
                            fireStore.collection("Basket").document(documentId).setData(additionalDictionary, merge: true) { error in
                                if error == nil {
                                    // hata yoksa
                                    ApplicationConstants.makeAlert(title: "Basarili", message: "Urun Sepete Eklendi", viewController: self)
                                }
                            }
                        }
                        
                    }
                } else {
                    //snapshot yoksa
                    let productDictionary = ["productArray": [["id":self.product.id ,"title":self.product.title ,"price":self.product.price ,"image":self.product.image] as [String : Any]] ,"userid":UserSingleton.sharedUserInfo.userid] as [String : Any]
                    
                    fireStore.collection("Basket").addDocument(data: productDictionary) { error in
                        if error != nil {
                            ApplicationConstants.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error!", viewController: self)
                        }else{
                            ApplicationConstants.makeAlert(title: "Basarili", message: "Urun Sepete Eklendi", viewController: self)
                        }
                    }
                }
            }
        }
    }
}

