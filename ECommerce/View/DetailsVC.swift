//
//  DetailsVC.swift
//  ECommerce
//
//  Created by Taha Turan on 17.05.2023.
//

import UIKit
import Firebase
import FirebaseFirestore

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
        
        let productDict = ["id":product.id ,"title":product.title ,"price":product.price ,"image":product.image , "count":1 , "description":product.description , "rate":product.rating.rate ,"ratingCount": product.rating.count , "category":product.category] as [String : Any]
        
        fireStore.collection("Basket").whereField("userid", isEqualTo: UserSingleton.sharedUserInfo.userid).getDocuments { snapshot , error in
            if error != nil {
                ApplicationConstants.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "Error!", viewController: self)
            }else{
                if snapshot?.isEmpty == false && snapshot != nil {
                    for document in snapshot!.documents{
                       
                        let documentId = document.documentID
                        if var productArray = document.get("productArray") as? [[String : Any]]{
                        
                            //urun daha once eklendi mi kontrolu
                            if productArray.contains(where: {$0["id"] as! Int == self.product.id }){
                                for product in productArray {
                                    
                                    if product["id"] as! Int == self.product.id {
                                        
                                        productArray.removeAll(where: { $0["id"] as! Int == product["id"] as! Int })
                                        
                                        let defaultCount = product["count"] as! Int
                                        let newCount = defaultCount + 1
                                      
                                        
                                        let defaultPrice = product["price"] as! Double
                                        let newPrice = defaultPrice + self.product.price
                                        
                                        
                                     
                                        let newProductDict = ["id":self.product.id ,"title":self.product.title ,"price":newPrice ,"image":self.product.image , "count":newCount ,"description":self.product.description , "rate":self.product.rating.rate ,"ratingCount": self.product.rating.count  , "category":self.product.category] as [String : Any]
                                        
                                        
                                        productArray.append(newProductDict)
                                        let additionalDictionary = ["productArray" : productArray] as [String : Any]
                                        fireStore.collection("Basket").document(documentId).setData(additionalDictionary, merge: true) { error in
                                            if error == nil {
                                                // hata yoksa
                                                ApplicationConstants.makeAlert(title: "Basarili", message: "Urun Sepete Eklendi", viewController: self)
                                            }
                                        }
                                    }
                                }
 
                            }else{
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
                    }
                } else {
                    //snapshot yoksa
                    let productDictionary = ["productArray": [["id":self.product.id ,"title":self.product.title ,"price":self.self.product.price ,"image":self.self.product.image , "count":1 , "description":self.product.description , "rate":self.product.rating.rate ,"ratingCount": self.product.rating.count , "category":self.product.category] as [String : Any]] ,"userid":UserSingleton.sharedUserInfo.userid] as [String : Any]
                    
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

