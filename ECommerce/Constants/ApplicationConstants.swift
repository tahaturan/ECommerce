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
}
