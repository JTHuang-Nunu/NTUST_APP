//
//  LoginManager.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/1.
//

import Foundation

class LoginManager{
    
    static let shared = LoginManager()
    
    func Login(Account: String, Password: String) {
            let url = URL(string: "http://127.0.0.1:5000/api/check_moodle_login")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let parameters: [String: Any] = [
                "username": Account,
                "password": Password
            ]
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
                return
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    print(responseJSON)
                }
            }
            
            task.resume()
        }
    
    func Logout(){
        print("Logout")
    }
    
    func CheckLoginStatus() -> Bool{
        return true
    }
    

}
