//
//  ProductSingleton.swift
//  ECommerce
//
//  Created by Taha Turan on 22.05.2023.
//

import Foundation


class ProductSingleton {

    static let sharedProductList = ProductSingleton()
    
     var poductList:ProductListViewModel = ProductListViewModel(productModelList: [ProductModel]())

    private init(){
        
    }
}
