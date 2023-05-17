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
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchBarViewModel:SearchBarViewModel = SearchBarViewModel(productModelList: [ProductModel]())
    
    var isSearch = false
    
    var selectedProduct : ProductViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designCell()
        collectionView.delegate = self
        collectionView.dataSource = self
        getDataProductList()
        
        searchBar.delegate = self
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdConstant.homePageToDetailPage {
            let destinationVC = segue.destination as! DetailsVC
            
            destinationVC.product = selectedProduct

        }
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
        
        if isSearch {
            return searchBarViewModel.productModelList.count
        }else{
            return self.productListViewModel == nil ?  0:self.productListViewModel.numberOfRowsInSection()
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        
      
        
        if isSearch{
            let product = self.searchBarViewModel.productAtIndex(indexPath.row)
            cell.titleLabel.text = "\(product.title)"
            cell.priceLabel.text = "\(product.price)$"
            cell.rateLabel.text = "\(product.rating.rate)"
            cell.productImageView.sd_setImage(with: URL(string: product.image))
        }else{
            let product = self.productListViewModel.productAtIndex(indexPath.row)
            cell.titleLabel.text = "\(product.title)"
            cell.priceLabel.text = "\(product.price)$"
            cell.rateLabel.text = "\(product.rating.rate)"
            cell.productImageView.sd_setImage(with: URL(string: product.image))
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if isSearch {
            let product = searchBarViewModel.productAtIndex(indexPath.row)
            selectedProduct = product
        }else{
            let product = productListViewModel.productAtIndex(indexPath.row)
            selectedProduct = product
        }
        

        
        performSegue(withIdentifier: SegueIdConstant.homePageToDetailPage, sender: nil)
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


//MARK: -SearchBar islemleri

extension HomePageVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("arama sonucu: \(searchText)")
        
        if searchText == "" {
            isSearch = false
        }else{
            isSearch = true
            
            searchBarViewModel.productModelList = productListViewModel.productModelList.filter({$0.title.lowercased().contains(searchText.lowercased())})
        }

        
        collectionView.reloadData()
    }
    
}
