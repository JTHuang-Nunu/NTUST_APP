//
//  MoodleManager.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/3.
//

import Foundation

//登入 moodle 回傳的 json
struct LoginResponse: Codable{
    var result: String
    var userid: Int
}

//課程列表回傳的 json
struct CoursesResponse: Codable {
    var data: [Courses]
    var result: String
}

//課程列表 json
struct Courses: Codable {
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

//單一課程資訊回傳的 json
struct CoursePageResponse: Codable {
    let courseid: Int
    let data: CoursePage
    let result: String
}

//單一課程資訊的 json
struct CoursePage: Codable {
    let week_list: [CourseWeek]
}

//課程資訊的 week
struct CourseWeek: Codable {
    let section: [CourseSection]
    let week: String
}

//課程資訊 week -> section
struct CourseSection: Codable {
    let icon_url: String
    let name: String
    let url: String
}

//日曆回傳的 json
struct CalendarResponse: Codable {
    let data: CalendarData
    let result: String
}

//日曆的 json
struct CalendarData: Codable {
    let month: Int
    let weeks: [[CalendarDay]]
    let year: Int
}

//日曆的 day json
struct CalendarDay: Codable {
    let events: [String]
    let mday: Int
}


class MoodleManager: ObservableObject {
    var host_ip = "127.0.0.1:8004"
    var userid: Int = 0
    @Published var login_status = false
    
    // 建立 Singleton
    static let shared = MoodleManager()
    
    /*
        func : 登入 moodle
        parameter : Account(帳號), Password(密碼)
        return : Bool(是否登入成功)
     */
    public func Login(Account: String, Password: String, completion: @escaping (Bool) -> Void) {
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
        func : 取得課程列表資訊
        parameter : None
        return : Bool(是否取得成功), [Courses](Courses 的 struct 陣列)
     */
    public func GetCourseList(completion: @escaping (Bool, [Courses]) -> Void){
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
        
        self.DebugPrint("GetCourseList", parameters.description)
        
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
                    let response_json = try decoder.decode(CoursesResponse.self, from: data)   //將解碼資料儲存在 codable 的 struct
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
    
    /*
        func : 取得單一課程資訊
        parameter : None
        return : Bool(是否取得成功), CoursePage(CoursePage 的 struct)
     */
    public func GetCouesePage(id:Int, completion: @escaping (Bool, CoursePage?) -> Void){
        //取得 CoursePage 的 api url
        let url = URL(string: "http://\(host_ip)/api/get_CoursePage")!
        
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
        
        self.DebugPrint("GetCouesePage", parameters.description)
        
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
                    let response_json = try decoder.decode(CoursePageResponse.self, from: data)   //將解碼資料儲存在 codable 的 struct
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
    
    /*
        func : 取得日曆資訊
        parameter : None
        return : Bool(是否取得成功), CalendarData(CalendarData 的 struct)
     */
    public func GetCalendar(year:Int, month:Int, completion: @escaping (Bool, CalendarData?) -> Void){
        //取得 CoursePage 的 api url
        let url = URL(string: "http://\(host_ip)/api/get_calendar")!
        
        //建立url request
        var request = URLRequest(url: url)
        
        //request method
        request.httpMethod = "POST"
        
        //request header`
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //POST parameter
        //{ "userid" : 0, "year" : 2023, "month" : 4}
        let parameters: [String: Any] = [
            "userid": userid,
            "year": year,
            "month": month
        ]
        
        self.DebugPrint("GetCalendar", parameters.description)
        
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
                self.DebugPrint("GetCalendar", error?.localizedDescription ?? "No data")
                completion(false, nil)
                return
            }
            
            // 將 data 轉換成 string
            if String(data: data, encoding: .utf8) != nil {
                // 讀取 json
                do {
                    
                    let decoder = JSONDecoder() //利用 json 解碼器
                    let response_json = try decoder.decode(CalendarResponse.self, from: data)   //將解碼資料儲存在 codable 的 struct
                    self.DebugPrint("GetCalendar", response_json.result) //result
                    completion(true, response_json.data)
                
                } catch {
                    self.DebugPrint("GetCalendar", "Error decoding JSON: \(error)")
                    completion(false, nil)
                }
            } else {
                self.DebugPrint("GetCalendar","Invalid JSON data")
                completion(false, nil)
            }
        }
        
        task.resume()
        
    }
    
    // 登出
    func Logout(){
        print("Logout")
    }
    
    // 檢查是否登入
    func CheckLoginStatus() -> Bool{
        return login_status
    }
    
    // 印出debug 資訊
    private func DebugPrint(_ func_name:String,_ message: String){
        print("[Moodle Manager] (\(func_name)): \(message)")
    }
    
    
    public func Test() {
        // UserDefaults.standard.set(calendarData, forKey: "calendarData")
        
        self.GetCourseList() { result, data in
            print(result)
            if !data.isEmpty {
                for course in data {
                    print("Course ID: \(course.course_id)")
                    print("Course Department: \(course.department)")
                    print("Course Fullname: \(course.fullname)")
                    print("Course Start Date: \(course.startdate)")
                    print("Course End Date: \(course.enddate)")
                    print("Course Progress: \(course.progress)")
                    print("Course View URL: \(course.viewurl)")
                    print("---")
                }
            }
        }
        self.GetCouesePage(id: 4932) { result, data  in
            print(result)
            if let data = data {
                for week in data.week_list {
                    print("Week: \(week.week)")
                    
                    for section in week.section {
                        print("Section Name: \(section.name)")
                        print("Icon URL: \(section.icon_url)")
                        print("URL: \(section.url)")
                        print("---")
                    }
                }
            }
        }
        self.GetCalendar(year: 2023, month: 5) { result, data in
            print(result)
            if let data = data {
                    print("Year: \(data.year)")
                    print("Month: \(data.month)")
                    
                    for week in data.weeks {
                        for day in week {
                            print("Day: \(day.mday)")
                            for event in day.events {
                                print("Event: \(event)")
                            }
                        }
                    }
                }
        }
    }
    
}

