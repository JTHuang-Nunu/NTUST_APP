//
//  MoodleManager.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/3.
//

import Foundation

class MoodleManager {
    public func Login(account: String, password: String){
        // TODO: Login
    }
    
    public func GetCourseList() -> [CourseInfo] {
        // TODO: Get Course List
        return []
    }
    
}
struct CourseInfo: Codable{
    var course_category: String
    var course_id: String
    var enddate: Date
    var fullname: String
    var hasprogress: Bool
    var progress: Int
    var startdate: Date
    var viewurl: String
}
