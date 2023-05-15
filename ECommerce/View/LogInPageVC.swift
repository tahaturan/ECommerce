//
//  ViewController.swift
//  ECommerce
//
//  Created by Taha Turan on 15.05.2023.
//

import UIKit

class LogInPageVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: SegueIdConstant.homePage, sender: nil)
    }
    
    
    @IBAction func googleLoginButtonClicked(_ sender: Any) {
    }
    
    
    @IBAction func appleLoginButtonClicked(_ sender: Any) {
    }
    

    
    @IBAction func createAccountButtonClicked(_ sender: Any) {
    }
    

}

