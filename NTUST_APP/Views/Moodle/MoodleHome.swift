//
//  MoodleHome.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/8.
//

import SwiftUI
import os

struct MoodleHome: View {
    @State var courseList: [Courses]? = nil
    @State var showLoginView = false
    @StateObject var moodleManager = MoodleManager.shared
    private let logger = Logger(subsystem: "Moodle", category: "MoodleHome")
    
    var body: some View {
        NavigationStack{
            Group{
                if moodleManager.login_status{
                    mainBody
                }else{
                    NeedLoginView(RequireLoginType: .Moodle){
                        showLoginView = true
                    }
                }
                
            }
            .navigationTitle("Moodle")
            .sheet(isPresented: $showLoginView){
                LoginView(loginType: .Moodle)
            }
        }
    }
    var mainBody: some View{
        VStack {
            Group {
                if self.courseList == nil{
                    ProgressView()
                }else{
                    CourseList
                }
            }
            .task{
                loadCourseList()
            }
        }
    }
    
    
    var CourseList: some View{
        List(courseList!, id: \.id){ course in
            NavigationLink(destination: CourseView(courseInfo: course)){
                CourseCard(courseInfo: course)
            }
        }
    }
    private func loadCourseList(){
        //assert(MoodleManager.shared.login_status == true)
        MoodleManager.shared.GetCourseList{ success, courses in
            if success{
                self.courseList = courses
                print(self.courseList?.count ?? 0)
            }else{
                logger.error("GetCourseList failed")
                self.courseList = nil
            }
            print("GetCourseList success: \(success)")
            
        }
    }

}


struct MoodleHome_Previews: PreviewProvider {
    static var previews: some View {
        MoodleHome(courseList: test_course_list)
    }
}

let test_course_list = [
    Courses(course_category: "", course_id: "0", department: "資工系", enddate: "", fullname: "編譯器設計", hasprogress: false, id: 1234, progress: 1, startdate: "", viewurl: "", shortname:""),
    Courses(course_category: "", course_id: "2", department: "資工系", enddate: "", fullname: "資料庫系統", hasprogress: false, id: 1235, progress: 1, startdate: "", viewurl: "", shortname:""),
    Courses(course_category: "", course_id: "3", department: "資工系", enddate: "", fullname: "IOS程式設計", hasprogress: false, id: 1236, progress: 1, startdate: "", viewurl: "", shortname:""),
    
]
