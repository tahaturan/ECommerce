//
//  UserSingleton.swift
//  ECommerce
//
//  Created by Taha Turan on 18.05.2023.
//

import Foundation

class UserSingleton {
    
    static let sharedUserInfo = UserSingleton()
    
    var userid = ""
    var email = ""
    var name = ""
    var userimage = ""
    var userCity = ""
    var userPhone = ""
    var userCountry = ""
    var userAddress = ""
    
    private init(){
        
    }
}
