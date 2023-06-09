//
//  NTUSTSystemManager.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/3.
//

import Foundation

class NTUSTSystemManager{
    var host_ip = "192.168.0.14:5000"
    var userid: Int = 0
    var login_status = false
    
    public func Login(Account: String, Password: String, completion: @escaping (Bool) -> Void) {
        //登入網址
        let url = URL(string: "http://\(host_ip)/api/check_ntust_login")!
        
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
        
        self.DebugPrint("Login", parameters.description)
        
        //執行 request
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            self.DebugPrint("Login", error.localizedDescription)
            completion(false) // 傳遞失敗結果
            return
        }
        
        // 建立網路請求的 task

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            //如果為空
            guard let data = data, error == nil else {
                self.DebugPrint("Login", error?.localizedDescription ?? "No data")
                completion(false) // 傳遞失敗結果
                return
            }
            
            // 將 data 轉換成 string
            if String(data: data, encoding: .utf8) != nil {
                // 讀取 json
                do {
                    let decoder = JSONDecoder() //利用 json 解碼器
                    let response_json = try decoder.decode(login_response.self, from: data)   //將解碼資料儲存在 codable 的 struct
                    self.userid = response_json.userid
                    
                    self.DebugPrint("Login", response_json.result)
                    self.login_status = true
                    completion(true)
                } catch {
                    self.DebugPrint("Login", "Error decoding JSON: \(error)")
                    completion(false)
                }
            } else {
                self.DebugPrint("Login", "Invalid JSON data")
                completion(false)
            }
        }
        
        task.resume()
    }
    
    private func DebugPrint(_ func_name:String,_ message: String){
        print("[Ntust System Manager Manager] (\(func_name)): \(message)")
    }
}
