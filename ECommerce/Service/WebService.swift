//
//  WebService.swift
//  ECommerce
//
//  Created by Taha Turan on 16.05.2023.
//

import Foundation

class WebService {
    
    func getProduct(url:URL , completion: @escaping ([ProductModel]?) -> () )  {
        
        URLSession.shared.dataTask(with: url) { data , response , error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }else if let data = data {
                
             let productList = try? JSONDecoder().decode([ProductModel].self, from: data)
                
                if let productList = productList {
                    completion(productList)
                }
                
            }
            
        }.resume()
        
    }
    
}


class WebServiceUrl {
    static let url = URL(string: "https://fakestoreapi.com/products")

}
