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
            let chname = parseFullName(fullName: courseInfo.fullname)
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
    
    func parseFullName(fullName: String) -> String {
        let pattern = #"【.+】([A-Za-z0-9]+)"#
        
        if let range = fullName.range(of: pattern, options: .regularExpression) {
            var name = String(fullName[range.upperBound...])
            name = name.replacingOccurrences(of: "[A-Za-z0-9]+", with: "", options: .regularExpression)
            name = name.replacingOccurrences(of: " ", with: "")
            name = name.replacingOccurrences(of: "(", with: " ")
            name = name.replacingOccurrences(of: ")", with: " ")
            return name
        }
        
        return ""
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
let test_course = Courses(course_category: "", course_id: "0", department: "資工系", enddate: "", fullname: "111.2【資工系】CS3010301 資料庫系統 Database Systems", hasprogress: false, id: 1234, progress: 1, startdate: "", viewurl: "")
