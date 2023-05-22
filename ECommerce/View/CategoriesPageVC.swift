//
//  CategoriesPageVC.swift
//  ECommerce
//
//  Created by Taha Turan on 15.05.2023.
//

import UIKit

class CategoriesPageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! CategoriListVC
        
        if segue.identifier == SegueIdConstant.categoryMens {
            destinationVC.filter = "men's clothing"
        }else if segue.identifier == SegueIdConstant.categoryWomens {
            destinationVC.filter = "women's clothing"
        }else if segue.identifier == SegueIdConstant.categoryJewelery {
            destinationVC.filter = "jewelery"
        }else if segue.identifier == SegueIdConstant.categoryElectonics{
            destinationVC.filter = "electronics"
        }
    }


}
