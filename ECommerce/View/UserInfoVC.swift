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
    
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    @IBOutlet weak var passwordHiddenButton: UIButton!
    
    var isHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
viewDesign()
    
    }
    

    @IBAction func passwordHiddenButtonClicked(_ sender: Any) {
        
        isHidden = !isHidden
        
        if isHidden {
            userPasswordTextField.isSecureTextEntry = false
            passwordHiddenButton.setImage(UIImage(named: "eyeIcon.png"), for: .normal)
        }else{
            userPasswordTextField.isSecureTextEntry = true
            passwordHiddenButton.setImage(UIImage(named: "closedEyeIcon.png"), for: .normal)
        }
    }
    
}


//MARK: - Design
extension UserInfoVC {
    func viewDesign()  {
        userImageView.layer.masksToBounds = true
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
        userPasswordTextField.isEnabled = true
        userPasswordTextField.isSecureTextEntry = true
        userPasswordTextField.text = "deneme"
        passwordHiddenButton.setImage(UIImage(named: "closedEyeIcon.png"), for: .normal)
        
        
 
    }
}
