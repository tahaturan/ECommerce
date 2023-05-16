//
//  HomePageViewModel.swift
//  ECommerce
//
//  Created by Taha Turan on 16.05.2023.
//

import Foundation

struct ProductListViewModel {
    let productModelList : [ProductModel]
    
    func numberOfRowsInSection() -> Int {
        return self.productModelList.count
    }
    
    
    func productAtIndex(_ index:Int) -> ProductViewModel {
        let product = self.productModelList[index]
        
        return ProductViewModel(productModel: product)
    }
    
}



struct ProductViewModel {
    let productModel : ProductModel
    
    var id: Int {
        return productModel.id
    }
    
    
    var title: String {
        return productModel.title
    }
    
    
    var price: Double {
        return productModel.price
    }
    var description:String {
        return productModel.description
    }
    var category: String {
        return productModel.category
    }
    var image: String {
        return productModel.image
    }
    var rating: Rating {
        return productModel.rating
    }
    
    
}
