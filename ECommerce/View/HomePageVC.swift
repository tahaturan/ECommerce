//
//  HomePageVC.swift
//  ECommerce
//
//  Created by Taha Turan on 15.05.2023.
//

import UIKit

class HomePageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        WebService().getProduct(url: WebServiceUrl.url!) { produtList in
            print(produtList ?? "")
        }
    }
    



}
