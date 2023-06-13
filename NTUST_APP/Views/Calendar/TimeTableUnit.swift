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
            if CourseName == ""{
                RoundedRectangle(cornerRadius: 2)
                    .stroke(Color.gray, lineWidth: 1)
                    .foregroundColor(BackFrameColor)
                    .shadow(color: .gray, radius: 3, x: 0, y: 0)
                    .opacity(0.3)
                
            }else{
                RoundedRectangle(cornerRadius: 2)
                    .stroke(Color.gray, lineWidth: 1)
                    .foregroundColor(BackFrameColor)
                    .shadow(color: .gray, radius: 3, x: 0, y: 0)
            }
            
            
            VStack{
                Text(CourseName)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.top, 5)
                Spacer()
                
                Text(CoursePlace)
                    .font(.caption2)
                    .fontWeight(.thin)
                    .padding(.bottom, 5)
            }
        }
        .frame(width: 60, height: 110)
    
    
    
    }
}

struct TimeTableUnit_Previews: PreviewProvider {
    static var previews: some View {
        TimeTableUnit(CourseName: "資料庫系統編譯器", CoursePlace: "TR-313", BackFrameColor: .blue)
    }
}
