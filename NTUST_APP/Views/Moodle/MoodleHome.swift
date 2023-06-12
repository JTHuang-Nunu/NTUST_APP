//
//  MoodleHome.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/8.
//

import SwiftUI
import os

struct MoodleHome: View {
    @State var courseList: [Courses] = []
    @State var showLoginView = false
    @State var loginState: LoginStatus = LoginStatus()
    private let logger = Logger(subsystem: "Moodle", category: "MoodleHome")
    
    var body: some View {
        NavigationStack{
            Group{
                if loginState.isLoginMoodle{
                    mainBody
                }else{
                    NeedLoginView(RequireLoginType: .Moodle){
                        showLoginView = true
                    }
                    .environmentObject(loginState)
                }
                
            }
            .navigationTitle("Moodle")
        }
        .sheet(isPresented: $showLoginView){
            LoginView(loginType: .Moodle)
        }
        .padding()
    }
    var mainBody: some View{
        ScrollView {
            CourseList
                .task{
                    loadCourseList()
            }
        }
    }
    
    var title: some View{
        HStack{
            Text("Moodle")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
            Spacer()
        }
        .padding(.horizontal)
    
    }
    
    
    var CourseList: some View{
        VStack{
            ForEach(courseList, id: \.course_id){ course in
                NavigationLink(destination: CourseView(courseInfo: course)){
                    CourseCard(courseInfo: course)
                }
            
            }
        
        }
    }
    
    private func loadCourseList(){
        //assert(MoodleManager.shared.login_status == true)
        MoodleManager.shared.GetCourseList{ success, courses in
            if success{
                self.courseList = courses
            }else{
                logger.error("GetCourseList failed")

            }
        }
    }

}
let test_course = Courses(course_category: "", course_id: "0", department: "資工系", enddate: "", fullname: "編譯器設計", hasprogress: false, id: 1234, progress: 1, startdate: "", viewurl: "")

struct MoodleHome_Previews: PreviewProvider {
    static var previews: some View {
        MoodleHome()
    }
}

let test_course_list = [
    Courses(course_category: "", course_id: "0", department: "資工系", enddate: "", fullname: "編譯器設計", hasprogress: false, id: 1234, progress: 1, startdate: "", viewurl: ""),
    Courses(course_category: "", course_id: "2", department: "資工系", enddate: "", fullname: "資料庫系統", hasprogress: false, id: 1235, progress: 1, startdate: "", viewurl: ""),
    Courses(course_category: "", course_id: "3", department: "資工系", enddate: "", fullname: "IOS程式設計", hasprogress: false, id: 1236, progress: 1, startdate: "", viewurl: ""),
    
]
