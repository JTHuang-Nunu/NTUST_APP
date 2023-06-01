//
//  LoginManager.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/1.
//

import Foundation

class LoginManager{
    
    static let shared = LoginManager()
    
    func Login(Account: String, Password: String){
        print("Login")
    }
    
    func Logout(){
        print("Logout")
    }
    
    func CheckLoginStatus() -> Bool{
        return true
    }
    

}
