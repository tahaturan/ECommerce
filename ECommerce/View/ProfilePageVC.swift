//
//  ProfilePageVC.swift
//  ECommerce
//
//  Created by Taha Turan on 15.05.2023.
//

import UIKit
import Firebase

class ProfilePageVC: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.sd_setImage(with: URL(string: UserSingleton.sharedUserInfo.userimage))
        
        let imageWitdh = profileImageView.frame.height
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = imageWitdh / 2
        
        let user = Auth.auth().currentUser
        
        
        
    }
    

    
    
    
    @IBAction func logOutButtonClicked(_ sender: Any) {
        
   logOut()

    }
    

}


//MARK: - Logout
extension ProfilePageVC{
    func logOut()  {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: SegueIdConstant.profileToLoginPage, sender: nil)
        } catch  {
            
        }
    }
}
