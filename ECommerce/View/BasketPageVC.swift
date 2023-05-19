//
//  BasketPageVC.swift
//  ECommerce
//
//  Created by Taha Turan on 15.05.2023.
//

import UIKit
import Firebase

class BasketPageVC: UIViewController {
    
    @IBOutlet weak var basketTableView: UITableView!
    
    @IBOutlet weak var ConfirmCardButton: UIButton!
    
    var userProductList = [BasketProductModel]()
    var totalPrice = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        basketTableView.delegate = self
        basketTableView.dataSource = self
        getProductFirebase()
        print("deneme")
        
        
    }
    
    @IBAction func ConfirmCardButtonClicked(_ sender: Any) {
        
    }
    
}


//MARK: -TableView islemleri
extension BasketPageVC: UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userProductList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = basketTableView.dequeueReusableCell(withIdentifier: "productTableCell" , for: indexPath) as! BasketTableViewCell
        
        let basketProduct = userProductList[indexPath.row].product
        let price = basketProduct["price"] as! Double
        let urlString = basketProduct["image"] as! String
        cell.titleLabel.text = basketProduct["title"] as? String
        cell.priceLabel.text = "\(price)$"
        cell.productImageView.sd_setImage(with: URL(string: urlString))
        
        
        return cell
    }
    
    
}


//MARK: Firebase Veri cekme islemi
extension BasketPageVC{
    func getProductFirebase() {
        let fireStoreDatabase = Firestore.firestore()
        
        fireStoreDatabase.collection("Basket").whereField("userid", isEqualTo: UserSingleton.sharedUserInfo.userid).addSnapshotListener { snapshot , error in
            if error != nil {
                ApplicationConstants.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "Error", viewController: self)
            }else {
                
                if snapshot?.isEmpty == false && snapshot != nil {
                    
                    self.userProductList.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents{
                        
                        if let fireProduct = document.get("productArray") as? [[String : Any]] {
                            
                            for product in fireProduct {
                                let userProduct = BasketProductModel(product: product)
                                self.userProductList.append(userProduct)
                                self.tabBarItem.badgeValue = String(self.userProductList.count)
                                self.totalPrice = self.totalPriceCalculate()
                                let buttonString:String = "Confirm Cart -> \(self.totalPrice)"
                                self.ConfirmCardButton.setTitle(buttonString, for: UIControl.State.normal)
                            }
                            
                        }
                        
                    }
                    self.basketTableView.reloadData()
                    
                }
                
            }
        }
    }
}

//MARK: -Total Price -- Toplam Tutar Hesaplama islemleri
extension BasketPageVC {
    
    func totalPriceCalculate() -> Double {
        
        var total = 0.0
        
        for product in userProductList{
            
           total += product.product["price"] as! Double
        }
        
        return total
    }
    
    
}
