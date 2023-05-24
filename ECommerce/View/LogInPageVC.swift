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
        logInApp()
    }
    
    
    @IBAction func googleLoginButtonClicked(_ sender: Any) {
        googleSignIn()
    }
    
    
    @IBAction func appleLoginButtonClicked(_ sender: Any) {
    }
    

    
    @IBAction func createAccountButtonClicked(_ sender: Any) {
    }
    

}



//MARK: - LogIn Button
extension LogInPageVC{
    func logInApp()  {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { result , error in
                
                if error != nil {
                    ApplicationConstants.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error", viewController: self)
                }else{
                    self.performSegue(withIdentifier: SegueIdConstant.logInPageTohomePage, sender: nil)
                }
                
            }
            
        }else{
            ApplicationConstants.makeAlert(title: "Error", message: "email/password ?", viewController: self)
        }
        
        
    }
}


//MARK: -Google SignIn
extension LogInPageVC{
    func googleSignIn()  {
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
                    
                    let fireStore = Firestore.firestore()
                    let userId = Auth.auth().currentUser?.uid
                    let userImage = Auth.auth().currentUser?.photoURL?.absoluteString
                    let userDictionary = ["userid":userId!,"email":user.profile!.email, "name":user.profile!.name , "userimage":userImage! , "userCity":"Bilgi Girilmemis" , "userPhone":"Bilgi Girilmemis" , "userCountry":"Bilgi Girilmemis" , "userAddress":"Bilgi Girilmemis"] as [String : Any]
                    
                    fireStore.collection("UserInfo").addDocument(data: userDictionary)
      
                    self.performSegue(withIdentifier: SegueIdConstant.logInPageTohomePage, sender: nil)
                }
            }
            
            
        }
    }
}
