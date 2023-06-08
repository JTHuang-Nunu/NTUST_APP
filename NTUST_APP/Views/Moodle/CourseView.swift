//
//  CourseView.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/8.
//

import SwiftUI

struct CourseView: View {
    var courseInfo: CourseInfo
    let tabItems = ["課程", "公告", "成績"]
    
    @State var selectedTab = 0
    
    
    var body: some View {
        VStack{
            Group{
                title
                courseInfoDisplay
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
            tabContent
            tab
        }
    
    }
    var title: some View{
        Text(courseInfo.fullname)
            .font(.title)
            .fontWeight(.bold)
            .padding()
    
    }
    var courseInfoDisplay: some View{
        VStack{
            Text("課程代碼: \(courseInfo.course_id)")
        }
    }
    var tabContent: some View{
        Group{
            switch selectedTab{
            case 0:
                Text("課程")
            case 1:
                Text("公告")
            case 2:
                Text("成績")
            default:
                EmptyView()
            }
        }
    }
    
    var tab: some View{
        HStack{
            ForEach(tabItems, id: \.self){ item in
                Button{
                    selectedTab = tabItems.firstIndex(of: item)!
                }label: {
                    Spacer()
                    Text(item)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                    Spacer()
                }
                
                    
            }
        
        }
    }
    
}

struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            let testInfo = CourseInfo(course_category: "", course_id: "", enddate: Date(), fullname: "CS3020301 編譯器設計 Compiler Design", hasprogress: false, progress: 0, startdate: Date(), viewurl: "")
            CourseView(courseInfo: testInfo)

        }
    }
}
