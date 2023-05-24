//
//  UserInfoVC.swift
//  ECommerce
//
//  Created by Taha Turan on 23.05.2023.
//

import UIKit
import Firebase
import FirebaseStorage

class UserInfoVC: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    @IBOutlet weak var userEmailLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDesign()
        
    }
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        changeProfileImage()
    }
    
    
}


//MARK: - Design
extension UserInfoVC: UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func viewDesign()  {
        userImageView.layer.masksToBounds = true
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
       
        userImageView.sd_setImage(with: URL(string: UserSingleton.sharedUserInfo.userimage))
        userNameLabel.text = "AD: \(UserSingleton.sharedUserInfo.name)"
        userEmailLabel.text = "Email: \(UserSingleton.sharedUserInfo.email)"
        
        
        userImageView.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        userImageView.addGestureRecognizer(gestureRecognizer)
        
 
    }
    
    
   @objc  func selectImage()  {
        let picker = UIImagePickerController()
       picker.delegate = self
       picker.sourceType = .photoLibrary
       self.present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        userImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
}


//MARK: -imageUplod islemleri firebase
extension UserInfoVC{
    func changeProfileImage()  {
        let storage = Storage.storage()
        
        let storageReference = storage.reference()
        
        let userProfileImage = storageReference.child("userProfileImage")
        
        if let data = userImageView.image?.jpegData(compressionQuality: 0.5){
            
            let uuid = UUID().uuidString
            
            let imageReference = userProfileImage.child("\(uuid).jpg")
            imageReference.putData(data) { metadata , error in
                if error != nil {
                    ApplicationConstants.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "Error", viewController: self)
                }else{
                    
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            
                            let fireStore = Firestore.firestore()
                            let userInfoDict = ["userimage":imageUrl!] as [String : Any]
                            
                            fireStore.collection("UserInfo").whereField("userid", isEqualTo: UserSingleton.sharedUserInfo.userid).addSnapshotListener { snapshot , error in
                                if error != nil {
                                    ApplicationConstants.makeAlert(title: "ERROR", message: error?.localizedDescription ?? "Error", viewController: self)
                                }else{
                                    
                                    if snapshot?.isEmpty == false && snapshot != nil {
                                        
                                        for document in snapshot!.documents {
                                            let documentId = document.documentID
                                            
                                            fireStore.collection("UserInfo").document(documentId).setData(userInfoDict, merge: true)
                                            
                                            UserSingleton.sharedUserInfo.userimage = imageUrl!
                                        }
                                        
                                    }
                                    
                                    
                                    
                                }
                            }
                            
                        }
                    }
                    
                    
                }
            }
            
        }
    }
}
