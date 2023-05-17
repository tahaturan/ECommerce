//
//  HomePageVC.swift
//  ECommerce
//
//  Created by Taha Turan on 15.05.2023.
//

import UIKit
import SDWebImage

class HomePageVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var productListViewModel:ProductListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designCell()
        collectionView.delegate = self
        collectionView.dataSource = self
        getDataProductList()
        }
    }



//MARK: -Verileri getirme getData
extension HomePageVC {
    
    func getDataProductList()  {
        WebService().getProduct(url: WebServiceUrl.url!) { productList in
            
            if let productList = productList {
                
                self.productListViewModel = ProductListViewModel(productModelList: productList)
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            }
            
        }
        
        
    }
    
}


//MARK: - CollectionView islemleri
extension HomePageVC : UICollectionViewDataSource , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productListViewModel == nil ?  0:self.productListViewModel.numberOfRowsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        
        let product = self.productListViewModel.productAtIndex(indexPath.row)
        
        cell.titleLabel.text = "\(product.title)"
        cell.priceLabel.text = "\(product.price)$"
        cell.rateLabel.text = "\(product.rating.rate)"
        cell.productImageView.sd_setImage(with: URL(string: product.image))
        return cell
    }
    
    
}


//MARK: CollectionView Tasarim

extension HomePageVC{
    func designCell()  {
        
        let design:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let width = self.collectionView.frame.size.width
        
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        design.minimumInteritemSpacing = 10
        design.minimumLineSpacing = 10
        
        let cellWidth = (width - 30) / 2
        
        design.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.6)
        collectionView!.collectionViewLayout = design
        
        
    }
}
