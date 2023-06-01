//
//  TimeTableUnit.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/1.
//

import SwiftUI

struct TimeTableUnit: View {
    var CourseName: String
    var BackFrameColor: Color
    
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 100, height: 100)
                .foregroundColor(BackFrameColor)
            Text(CourseName)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    
    
    }
}

struct TimeTableUnit_Previews: PreviewProvider {
    static var previews: some View {
        TimeTableUnit(CourseName: "Database", BackFrameColor: .blue)
    }
}
