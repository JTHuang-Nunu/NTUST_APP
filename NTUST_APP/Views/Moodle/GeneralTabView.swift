//
//  GeneralTabView.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/13.
//

import SwiftUI

struct GeneralTabView: View {
    var coursePage: CoursePage
    var body: some View {
        List {
            if let week = GetGeneralWeek(){
                WeekView(week: week)
                    .cornerRadius(10)
            }
            else{
                Text("沒有資訊")
            }
            
        }
    }
    func GetGeneralWeek() -> CourseWeek?{
        for week in coursePage.week_list {
            if week.week == "一般" {
                return week
            }
        }
        return nil
    }
}

struct GeneralTabView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralTabView(coursePage: testCoursePage)
    }
}
