//
//  LoginManager.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/1.
//

import Foundation

class LoginManager{
    struct info {
        var userid = 0
    }
    
    static let shared = LoginManager()
    
    func Login(Account: String, Password: String, completion: @escaping (Bool) -> Void) {
        
        //登入網址
        let url = URL(string: "http://127.0.0.1:5000/api/check_moodle_login")!
        
        //建立url request
        var request = URLRequest(url: url)
        
        //request method
        request.httpMethod = "POST"
        
        //request header
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //POST parameter
        let parameters: [String: Any] = [
            "username": Account,
            "password": Password
        ]
        
        //執行 request
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            completion(false) // 傳遞失敗結果
            return
        }
        
        // 建立網路請求的 task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            //如果為空
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                completion(false) // 傳遞失敗結果
                return
            }
            //取得回應
            if let responseJSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                if let result = responseJSON["result"] as? String {
                    if result == "true" {
                        completion(true) // 傳遞成功結果
                        return
                    }
                }
            }
            completion(false) // 傳遞預設的失敗結果
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
