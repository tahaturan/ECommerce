//
//  ViewController.swift
//  ECommerce
//
//  Created by Taha Turan on 15.05.2023.
//

import UIKit
import Firebase
import GoogleSignIn

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
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
          guard error == nil else {
            return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { result , error in
                if error != nil {
                    ApplicationConstants.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error", viewController: self)
                }else{
                    self.performSegue(withIdentifier: SegueIdConstant.homePage, sender: nil)
                }
            }
        }
    }
    
    
    @IBAction func appleLoginButtonClicked(_ sender: Any) {
    }
    

    
    @IBAction func createAccountButtonClicked(_ sender: Any) {
    }
    

}

