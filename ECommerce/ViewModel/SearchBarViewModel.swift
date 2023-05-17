//
//  SearchBarViewModel.swift
//  ECommerce
//
//  Created by Taha Turan on 17.05.2023.
//

import Foundation


struct SearchBarViewModel {
    var productModelList : [ProductModel]

    func productAtIndex(_ index:Int) -> ProductViewModel {
        let product = self.productModelList[index]
        
        return ProductViewModel(productModel: product)
    }
}
