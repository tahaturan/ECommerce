//
//  ApplicationConstants.swift
//  ECommerce
//
//  Created by Taha Turan on 15.05.2023.
//

import Foundation
import UIKit

class ApplicationConstants {
  static  func makeAlert(title:String , message:String , viewController:UIViewController)  {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okButton)
        viewController.present(alert, animated: true)
    }
    
    
    static let defaultImageUrl:String = "https://firebasestorage.googleapis.com/v0/b/ecommerceapp-a9a9f.appspot.com/o/userProfileImage%2FdefaultProfile.png?alt=media&token=1761a66e-7672-4455-aa41-2dcdef4c5307"
}
