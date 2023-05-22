//
//  CategoriListVC.swift
//  ECommerce
//
//  Created by Taha Turan on 22.05.2023.
//

import UIKit

class CategoriListVC: UIViewController {
    
    var produtcList = ProductSingleton.sharedProductList.poductList
    var filter:String = ""
    var filterListProduct : ProductListViewModel!
    var selectedProduct : ProductViewModel!
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let filterList = produtcList.productModelList.filter({$0.category == filter})
        filterListProduct = ProductListViewModel(productModelList: filterList)
        
        categoryNameLabel.text = filter
        
        tableView.delegate = self
        tableView.dataSource = self

        
    }
    



}

//MARK: -TableView islemleri
extension CategoriListVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return filterListProduct.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CaregoryTableViewCell
        
        let product = filterListProduct.productAtIndex(indexPath.row)
        
        cell.descriptionLabel.text = product.description
        cell.priceLabel.text = "\(product.price)$"
        cell.titleLabel.text = product.title
        cell.productImageView.sd_setImage(with: URL(string: product.image))
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = filterListProduct.productAtIndex(indexPath.row)
        selectedProduct = product
        performSegue(withIdentifier: SegueIdConstant.categoryToDetails, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdConstant.categoryToDetails {
            let destinationVC = segue.destination as! DetailsVC
            
            destinationVC.product = selectedProduct
        }
    }
    
}
