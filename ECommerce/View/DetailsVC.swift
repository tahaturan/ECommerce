//
//  DetailsVC.swift
//  ECommerce
//
//  Created by Taha Turan on 17.05.2023.
//

import UIKit

class DetailsVC: UIViewController {
    
    var product : ProductViewModel! = nil
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewDesign()

        
    }
    

    @IBAction func addBasketButtonClicked(_ sender: Any) {
    }
    

}



//MARK: - design
extension DetailsVC {
    
    func viewDesign()  {
        
        if let product = product {
            imageView.sd_setImage(with: URL(string: product.image))
            titleLabel.text = product.title
            descriptionLabel.text = product.description
            priceLabel.text = "\(product.price)$"
        }
        
    }
}
