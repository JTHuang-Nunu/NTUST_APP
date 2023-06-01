//
//  SchoolTimeTable.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/1.
//

import SwiftUI

struct SchoolTimeTable: View {
    
    var body: some View {
        table
    }
    let columns = Array(repeating: GridItem(.flexible()), count: 5)
    
    var table: some View{
        ZStack{
            Grid{
                GridRow{
                    TimeTableUnit(CourseName: "Database", BackFrameColor: .blue)
                    TimeTableUnit(CourseName: "Database", BackFrameColor: .blue)
                }
            }
        }
    }
}
struct SectionInfo{
    var CourseName: String = ""
    var CoursePlace: String = ""
}
struct DaySections{
    var DaySections: [Int:SectionInfo] = [:]
    init(){
        for i in 0..<13{
            DaySections[i] = SectionInfo()
        }
    }

}
struct WeekSections{
    var WeekSections: [Int:DaySections] = [:]
    init(){
        for i in 0..<5{
            WeekSections[i] = DaySections()
        }
    }
}


struct SchoolTimeTable_Previews: PreviewProvider {
    static var previews: some View {
        SchoolTimeTable()
    }
}
