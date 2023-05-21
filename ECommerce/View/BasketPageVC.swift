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
    
    @IBOutlet weak var confirmCardButton: UIButton!
    
    let fireStoreDatabase = Firestore.firestore()
    
    var userProductList = [ProductViewModel]()
    var totalPrice = 0.0
    
    var selectedProduct : ProductViewModel!
    
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
        
        let basketProduct = userProductList[indexPath.row]
        
        let urlString = basketProduct.image
        cell.titleLabel.text = basketProduct.title
        cell.priceLabel.text = "\(basketProduct.price)$"
        cell.productImageView.sd_setImage(with: URL(string: urlString))
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { contextualAction, view, boolValue in
           
            let product = self.userProductList[indexPath.row]
            self.updateDataBase(id: product.id)
            self.basketTableView.reloadData()
           
         
            
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let userSelect = userProductList[indexPath.row]
        selectedProduct = userSelect
        
        performSegue(withIdentifier: SegueIdConstant.basketToDetails, sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdConstant.basketToDetails {
            let destinationVC = segue.destination as! DetailsVC
            
            destinationVC.product = selectedProduct
        }
    }
    
    
}


//MARK: Firebase Veri cekme islemi
extension BasketPageVC{
    func getProductFirebase() {
        
        
        fireStoreDatabase.collection("Basket").whereField("userid", isEqualTo: UserSingleton.sharedUserInfo.userid).addSnapshotListener { snapshot , error in
            if error != nil {
                ApplicationConstants.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "Error", viewController: self)
            }else {
                
                if snapshot?.isEmpty == false && snapshot != nil {
                    
                    self.userProductList.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents{
                        
                        if let fireProduct = document.get("productArray") as? [[String : Any]] {
                            
                            if fireProduct.count > 0 {
                                for product in fireProduct {
                                    
                                    let title = product["title"] as! String
                                    let price = product["price"] as! Double
                                    let id = product["id"] as! Int
                                    let image = product["image"] as! String
                                    let description = product["description"] as! String
                                    let rate = product["rate"] as! Double
                                    let ratingCount = product["ratingCount"] as! Int
                                    let category = product["category"] as! String
                                    
                                    let createProdcutRating = Rating(rate: rate, count: ratingCount)
                                    let createProduct = ProductModel(id: id, title: title, price: price, description: description, category: category, image: image, rating: createProdcutRating)
                                    
                                    self.userProductList.append(ProductViewModel(productModel: createProduct))
                                    self.tabBarItem.badgeValue = String(self.userProductList.count)
                                    self.totalPrice = self.totalPriceCalculate()
                                    let buttonString:String = "Confirm Cart -> \(self.totalPrice)"
                                    self.confirmCardButton.isHidden = false
                                    self.confirmCardButton.setTitle(buttonString, for: UIControl.State.normal)
                                }
                            
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
        
        if userProductList.count > 0 {
            for product in userProductList{
                
                total += product.price
            }
        }
        
        return total
    }
    
    
}



//MARK: Sepetten veri sildinginde Firebase veritabanin guncellenmesi
extension BasketPageVC {
    func updateDataBase(id:Int) {
        
        fireStoreDatabase.collection("Basket").whereField("userid", isEqualTo: UserSingleton.sharedUserInfo.userid).addSnapshotListener { snapshot , error in
            if error != nil {
                ApplicationConstants.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "Error!", viewController: self)
            }else{
                if snapshot?.isEmpty == false && snapshot != nil {
                    for document in snapshot!.documents{
                        
                        let documentId = document.documentID
                        
                        if var productArray = document.get("productArray") as? [[String : Any]] {
                          
                            if productArray.count > 0 {
                                productArray.removeAll(where: {$0["id"] as! Int == id})
                                
                                let newProductDict = ["productArray" : productArray] as [String : Any]
                                
                                self.fireStoreDatabase.collection("Basket").document(documentId).setData(newProductDict, merge: true)
                                
                                if productArray.count == 0 {
                                    self.totalPrice = 0.0
                                    self.tabBarItem.badgeValue = nil
                                    self.confirmCardButton.isHidden = true
                                }

                            }
                            
                        }
                        
                     
                    }
                    self.basketTableView.reloadData()
                }
            }
        }
    }
    
}
