//
//  CaregoryTableViewCell.swift
//  ECommerce
//
//  Created by Taha Turan on 22.05.2023.
//

import UIKit

class CaregoryTableViewCell: UITableViewCell {
    
  
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
