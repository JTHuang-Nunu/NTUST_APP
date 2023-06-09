//
//  MoodleManager.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/3.
//

import Foundation

struct login_response: Codable{
    var result: String
    var userid: Int
}

struct courses_response: Codable {
    var data: [courses]
    var result: String
}

struct courses: Codable {
    var course_category: String
    var course_id: String
    var department: String
    var enddate: String
    var fullname: String
    var hasprogress: Bool
    var id: Int
    var progress: Int
    var startdate: String
    var viewurl: String
}

struct course_page_response: Codable {
    let courseid: Int
    let data: course_page
    let result: String
}

struct course_page: Codable {
    let week_list: [CourseWeek]
}

struct CourseWeek: Codable {
    let section: [course_section]
    let week: String
}

struct course_section: Codable {
    let icon_url: String
    let name: String
    let url: String
}


class MoodleManager {
    var host_ip = "192.168.0.14:5000"
    var userid: Int = 0
    var login_status = false
        
    static let shared = MoodleManager()
    
    /*
        func : 登入 moodle
        parameter : Account(帳號), Password(密碼)
        return : Bool(是否登入成功)
     */
    public func Login(Account: String, Password: String, completion: @escaping (Bool) -> Void) {
        self.DebugPrint("Login", Account)
        self.DebugPrint("Login", Password)

        //登入網址
        let url = URL(string: "http://\(host_ip)/api/check_moodle_login")!
        
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
    
    func Logout(){
        print("Logout")
    }
    
    func CheckLoginStatus() -> Bool{
        return login_status
    }
    
    /*
        func : 取得課程列表
        parameter : None
        return : Bool(是否取得成功), [courses](courses 的 struct 陣列)
     */
    public func GetCourseList(completion: @escaping (Bool, [courses]) -> Void){
        //取得 CourseList 的 api url
        let url = URL(string: "http://\(host_ip)/api/get_courses")!
        
        //建立url request
        var request = URLRequest(url: url)
        
        //request method
        request.httpMethod = "POST"
        
        //request header`
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //POST parameter
        //{ "userid" : "0", "classification" : "inprogress", "sort" : "fullname"}
        let parameters: [String: Any] = [
            "userid": userid,
            "classification": "inprogress",
            "sort": "fullname"
        ]
        
        //執行 request
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        // 建立網路請求的 task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // 如果回傳為空
            guard let data = data, error == nil else {
                self.DebugPrint("GetCourseList", error?.localizedDescription ?? "No data")
                completion(false, [])
                return
            }
            
            // 將 data 轉換成 string
            if String(data: data, encoding: .utf8) != nil {
                // 讀取 json
                do {
                    
                    let decoder = JSONDecoder() //利用 json 解碼器
                    let response_json = try decoder.decode(courses_response.self, from: data)   //將解碼資料儲存在 codable 的 struct
                    self.DebugPrint("GetCourseList", response_json.result) //result
                    completion(true, response_json.data)
                
                } catch {
                    self.DebugPrint("GetCourseList", "Error decoding JSON: \(error)")
                    completion(false, [])
                }
            } else {
                self.DebugPrint("GetCourseList","Invalid JSON data")
                completion(false, [])
            }
        }
        
        task.resume()
    }
    
    
    public func GetCouesePage(id:Int, completion: @escaping (Bool, course_page?) -> Void){
        //取得 CoursePage 的 api url
        let url = URL(string: "http://\(host_ip)/api/get_course_page")!
        
        //建立url request
        var request = URLRequest(url: url)
        
        //request method
        request.httpMethod = "POST"
        
        //request header`
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //POST parameter
        //{ "userid" : "0", "courseid" : "4932"}
        let parameters: [String: Any] = [
            "userid": userid,
            "courseid": id
        ]
        
        //執行 request
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        // 建立網路請求的 task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // 如果回傳為空
            guard let data = data, error == nil else {
                self.DebugPrint("GetCouesePage", error?.localizedDescription ?? "No data")
                completion(false, nil)
                return
            }
            
            // 將 data 轉換成 string
            if String(data: data, encoding: .utf8) != nil {
                // 讀取 json
                do {
                    
                    let decoder = JSONDecoder() //利用 json 解碼器
                    let response_json = try decoder.decode(course_page_response.self, from: data)   //將解碼資料儲存在 codable 的 struct
                    self.DebugPrint("GetCouesePage", response_json.result) //result
                    completion(true, response_json.data)
                
                } catch {
                    self.DebugPrint("GetCouesePage", "Error decoding JSON: \(error)")
                    completion(false, nil)
                }
            } else {
                self.DebugPrint("GetCouesePage","Invalid JSON data")
                completion(false, nil)
            }
        }
        
        task.resume()
        
    }
    
    private func DebugPrint(_ func_name:String,_ message: String){
        print("[MoodleManager] (\(func_name)): \(message)")
    }
    
    public func Test() {
        self.GetCourseList() { result, course in
            print(result)
            print(course)
        
        }
//        self.GetCouesePage(id: 4932) { result in
//
//        }
    }
    
}

