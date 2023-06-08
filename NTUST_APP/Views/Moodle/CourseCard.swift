//
//  CourseCard.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/8.
//

import SwiftUI

struct CourseCard: View {
    var CourseName: String
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                .frame(height: 200)
            Text(CourseName)
                .font(.system(size: 24, weight: .bold))
                .frame(width: 200, height: 100, alignment: .topLeading)
                .padding(.top, 20)
                .padding(.leading, 20)
        }
        .frame(width: 300, height: 150)
        .padding()
    }
}

struct CourseCard_Previews: PreviewProvider {
    static var previews: some View {
        CourseCard(CourseName: "資料庫")
    }
}
