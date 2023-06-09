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
        ZStack {
            background
            VStack(alignment: .leading) { // 使用 .leading 來將文本靠左對齊
                Text(courseInfo.fullname)
                    .font(.title)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .padding(.top, 40)
                    .padding(.leading, 40)
                
                Text(courseInfo.department)
                    .font(.system(size: 18, weight: .bold))
                    .lineLimit(1)
                    .padding(.leading, 40)
                
                Spacer() // 將文本推到最上方
                
            }
            .frame(minWidth: 300, maxWidth: 500, minHeight: 150, maxHeight: 500)
        .padding()
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
