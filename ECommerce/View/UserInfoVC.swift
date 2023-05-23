//
//  UserInfoVC.swift
//  ECommerce
//
//  Created by Taha Turan on 23.05.2023.
//

import UIKit
import Firebase

class UserInfoVC: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    @IBOutlet weak var userEmailLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDesign()
        
    }
}


//MARK: - Design
extension UserInfoVC {
    func viewDesign()  {
        userImageView.layer.masksToBounds = true
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
       
        userImageView.sd_setImage(with: URL(string: UserSingleton.sharedUserInfo.userimage))
        userNameLabel.text = "AD: \(UserSingleton.sharedUserInfo.name)"
        userEmailLabel.text = "Email: \(UserSingleton.sharedUserInfo.email)"
        
        
        
 
    }
}
