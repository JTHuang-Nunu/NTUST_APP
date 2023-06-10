//
//  NTUSTSystemManager.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/3.
//

import Foundation

struct ScoreDataResponse: Codable {
    let data: [Score]
    let result: String
}

struct Score: Codable {
    let academic_year: Int  // 學年期
    let average_score: Double   // 平均成績
    let average_score_cumulative: Double    // 平均成績 (歷年)
    let class_rank: Int // 班排
    let class_rank_cumulative: Int  // 班排 (歷年)
    let department_rank: Int    // 系排
    let department_rank_cumulative: Int // 系排 (歷年)
}

struct CourseTableResponse: Codable {
    let data: [CourseTableRow]
    let result: String
}

struct CourseTableRow: Codable {
    let Monday: String
    let Tuesday: String
    let Wednesday: String
    let Thursday: String
    let Friday: String
    let Saturday: String
    let Sunday: String
    let Time: String
    let Period: String
}




class NTUSTSystemManager{
    var host_ip = "192.168.137.137:5000"
    var userid: Int = 0
    var login_status = false
    
    //Ntust System Manager Singleton
    static let shared = NTUSTSystemManager()
    
    /*
        func : 登入ntust system
        parameter : None
        return : Bool(是否登入成功)
     */
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
                    let response_json = try decoder.decode(LoginResponse.self, from: data)   //將解碼資料儲存在 codable 的 struct
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
    
    /*
        func : 取得歷年成績
        parameter : None
        return : Bool(是否取得成功), [courses](courses 的 struct 陣列)
     */
    public func GetNtustScore(completion: @escaping (Bool, [Score]) -> Void){
        //取得 CourseList 的 api url
        let url = URL(string: "http://\(host_ip)/api/get_ntust_score")!
        
        //建立url request
        var request = URLRequest(url: url)
        
        //request method
        request.httpMethod = "POST"
        
        //request header`
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //POST parameter
        //{ "userid" : "0"}
        let parameters: [String: Any] = [
            "userid": userid
        ]
        
        self.DebugPrint("GetNtustScore", parameters.description)
        
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
                self.DebugPrint("GetNtustScore", error?.localizedDescription ?? "No data")
                completion(false, [])
                return
            }
            
            // 將 data 轉換成 string
            if String(data: data, encoding: .utf8) != nil {
                // 讀取 json
                do {
                    let decoder = JSONDecoder() //利用 json 解碼器
                    let response_json = try decoder.decode(ScoreDataResponse.self, from: data)   //將解碼資料儲存在 codable 的 struct
                    self.DebugPrint("GetNtustScore", response_json.result) //result
                    completion(true, response_json.data)
                
                } catch {
                    self.DebugPrint("GetNtustScore", "Error decoding JSON: \(error)")
                    completion(false, [])
                }
            } else {
                self.DebugPrint("GetNtustScore","Invalid JSON data")
                completion(false, [])
            }
        }
        
        task.resume()
    }
    
    
    /*
        func : 取得課表
        parameter : None
        return : Bool(是否取得成功), [courses](courses 的 struct 陣列)
     */
    public func GetNtustCourseTable(completion: @escaping (Bool, [CourseTableRow]) -> Void){
        //取得 CourseList 的 api url
        let url = URL(string: "http://\(host_ip)/api/get_course_table")!
        
        //建立url request
        var request = URLRequest(url: url)
        
        //request method
        request.httpMethod = "POST"
        
        //request header`
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //POST parameter
        //{ "userid" : "0"}
        let parameters: [String: Any] = [
            "userid": userid
        ]
        
        self.DebugPrint("GetNtustCourseTable", parameters.description)
        
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
                self.DebugPrint("GetNtustCourseTable", error?.localizedDescription ?? "No data")
                completion(false, [])
                return
            }
            
            // 將 data 轉換成 string
            if String(data: data, encoding: .utf8) != nil {
                // 讀取 json
                do {
                    let decoder = JSONDecoder() //利用 json 解碼器
                    let response_json = try decoder.decode(CourseTableResponse.self, from: data)   //將解碼資料儲存在 codable 的 struct
                    self.DebugPrint("GetNtustCourseTable", response_json.result) //result
                    completion(true, response_json.data)
                
                } catch {
                    self.DebugPrint("GetNtustCourseTable", "Error decoding JSON: \(error)")
                    completion(false, [])
                }
            } else {
                self.DebugPrint("GetNtustCourseTable","Invalid JSON data")
                completion(false, [])
            }
        }
        
        task.resume()
    }
    //不可同時執行 需註解一個
    public func Test() {
            
//        NTUSTSystemManager.shared.GetNtustScore() { result, data in
//            if result {
//                // 登入成功
//                print("GetScoreData successful")
//
//                for score in data {
//                    print("Academic Year: \(score.academic_year)")
//                    print("Average Score: \(score.average_score)")
//                    print("Average Score Cumulative: \(score.average_score_cumulative)")
//                    print("Class Rank: \(score.class_rank)")
//                    print("Class Rank Cumulative: \(score.class_rank_cumulative)")
//                    print("Department Rank: \(score.department_rank)")
//                    print("Department Rank Cumulative: \(score.department_rank_cumulative)")
//                    print("--------------------")
//                }
//
//            } else {
//                // 登入失敗
//                print("GetScoreData failed")
//            }
//        }
        
        NTUSTSystemManager.shared.GetNtustCourseTable() { result, data in
            if result {
                // 登入成功
                print("GetCourseTableData successful")
                
                for classPeriod in data {
                        print("Period: \(classPeriod.Period)")
                        print("Time: \(classPeriod.Time)")
                        print("Monday: \(classPeriod.Monday)")
                        print("Tuesday: \(classPeriod.Tuesday)")
                        print("Wednesday: \(classPeriod.Wednesday)")
                        print("Thursday: \(classPeriod.Thursday)")
                        print("Friday: \(classPeriod.Friday)")
                        print("Saturday: \(classPeriod.Saturday)")
                        print("Sunday: \(classPeriod.Sunday)")
                        print("---------------------------")
                    }
                
            } else {
                // 登入失敗
                print("GetCourseTableData failed")
            }
        }
    }
        
    private func DebugPrint(_ func_name:String,_ message: String){
        print("[Ntust System Manager Manager] (\(func_name)): \(message)")
    }
}
