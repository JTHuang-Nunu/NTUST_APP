//
//  TimeTableUnit.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/1.
//

import SwiftUI

struct TimeTableUnit: View {
    var CourseName: String
    var CoursePlace: String = ""
    
    var BackFrameColor: Color
    
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray, lineWidth: 1)
                .foregroundColor(BackFrameColor)
                .shadow(color: .gray, radius: 3, x: 0, y: 0)
            
            VStack{
                Text(CourseName)
                    .font(.body)
                    .fontWeight(.bold)
                    .padding(.top)
                Spacer()
                
                Text(CoursePlace)
                    .font(.caption2)
                    .fontWeight(.thin)
                    .padding(.bottom)
            }
        }
        .frame(width: 60, height: 80)
    
    
    
    }
}

struct TimeTableUnit_Previews: PreviewProvider {
    static var previews: some View {
        TimeTableUnit(CourseName: "資料庫", CoursePlace: "TR-313", BackFrameColor: .white)
    }
}
