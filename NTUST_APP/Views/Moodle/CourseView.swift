//
//  CourseView.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/8.
//

import SwiftUI
import os

struct CourseView: View {
    
    let courseInfo: Courses
    let tabItems = ["課程", "公告", "成績"]
    @State var coursePage: CoursePage? = nil
    
    @State var selectedTab = 0
    
    private let logger = Logger(subsystem: "Moodle", category: "CourseView")
    
    var body: some View {
        VStack{
            VStack {
                title
                courseInfoDisplay
                Spacer()
            }
            tabContent
            tab
        }
        .task{
            loadCoursePage()
        }
    
    }
    var title: some View{
        HStack{
            Text("編譯器設計")
                .font(.title)
                .fontWeight(.bold)
                .padding()

        }
    }
    var courseInfoDisplay: some View{
        VStack{
            Text("課程代碼: ")
        }
    }
    var tabContent: some View{
        Group {
            if let coursePage = coursePage {
                
                switch selectedTab{
                case 0:
                    SectionTabView(coursePage: coursePage)
                case 1:
                    Text("公告")
                case 2:
                    Text("成績")
                default:
                    EmptyView()
                }
            }else{
                ProgressView()
            
            }
        }
    }
    
    var tab: some View {
        HStack(spacing: 0) {
            ForEach(tabItems, id: \.self) { item in
                Button(action: {
                    selectedTab = tabItems.firstIndex(of: item)!
                }) {
                    Text(item)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .background(selectedTab == tabItems.firstIndex(of: item) ? Color.indigo : Color.clear)
                .foregroundColor(selectedTab == tabItems.firstIndex(of: item) ? .white : .black)
            }
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding()
    }


    
    private func loadCoursePage(){
        //assert(MoodleManager.shared.login_status == true)
        MoodleManager.shared.GetCouesePage(id: courseInfo.id){ seccess, page in
            if seccess{
                coursePage = page
            }else{
                logger.error("GetCoursePage failed")
            
            }
        }
    }
    
}

struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            //CourseView(courseInfo: <#T##Courses#>)

        }
    }
}
