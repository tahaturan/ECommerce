//
//  SignUpVC.swift
//  ECommerce
//
//  Created by Taha Turan on 15.05.2023.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        signUpFirebase()
        
    }
}

//MARK: - Firebase SignUp islemleri
extension SignUpVC{
    
    func signUpFirebase() {
        if emailTextField.text != "" && passwordTextField.text != ""{
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { result , error in
                if error != nil {
                    ApplicationConstants.makeAlert(title: "Error", message: error?.localizedDescription ?? "", viewController: self)
                }else{
                    self.performSegue(withIdentifier: SegueIdConstant.signUpToLoginVC, sender: nil)
                }
            }
            
        }else{
            ApplicationConstants.makeAlert(title: "Error", message: "email/password ? ", viewController: self)
        }
    }
    
}
        
    
    

