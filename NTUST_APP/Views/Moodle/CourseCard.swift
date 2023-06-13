//
//  CourseCard.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/8.
//

import SwiftUI

struct CourseCard: View {
    var courseInfo: Courses
    
    var body: some View {

        VStack(alignment: .leading) {
            let chname = courseInfo.shortname
            Text(chname)
                .font(.title2)
                .fontWeight(.bold)
                .lineLimit(1)
                .padding(.top, 5)
                .padding(.leading, 5)
            
            Text(courseInfo.department)
                .font(.caption)
                .fontWeight(.light)
                .lineLimit(1)
                .padding(.leading, 5)
            
        }

        
    }


    
    var background: some View{
        RoundedRectangle(cornerRadius: 25, style: .continuous)
            .fill(Color.white)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
            .aspectRatio(1.5, contentMode: .fit)
    }
}


struct CourseCard_Previews: PreviewProvider {
    static var previews: some View {
        CourseCard(courseInfo: test_course)
    }
}
let test_course = Courses(course_category: "", course_id: "0", department: "資工系", enddate: "", fullname: "111.2【資工系】CS3010301 資料庫系統 Database Systems", hasprogress: false, id: 1234, progress: 1, startdate: "", viewurl: "", shortname: "")
