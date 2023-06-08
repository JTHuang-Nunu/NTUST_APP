//
//  SchoolTimeTable.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/1.
//

import SwiftUI

struct SchoolTimeTable: View {
    var weekdays = ["星期一", "星期二", "星期三", "星期四", "星期五"]
    var times = ["08:10", "09:00", "09:50", "10:40", "11:30", "12:20", "13:10", "14:00", "14:50", "15:40", "16:30", "17:20", "18:10"]
    @State private var showTimesColumn = false
    var weekBar : some View{
        GridRow {
            if showTimesColumn{
                Color.clear
                    .gridCellUnsizedAxes([.horizontal, .vertical])
            }else{
                EmptyView()
            }
            ForEach(0..<5) { column in
                Text(weekdays[column])
            }
        }
    }
    
    var body: some View {
        VStack {
            ScrollView {
                table
                    .padding()
                    
            }
        }
        .navigationTitle("課表")
    }
    
    var table: some View {
        Grid {
            weekBar
            ForEach(0..<times.count){ index in
                GridRow {
                    timeLabel(time: times[index])
                    daySections
                }
                
            }
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    withAnimation(.easeInOut(duration: 0.3))  {
                        if value.translation.width > 0 {
                            showTimesColumn = true
                        }
                        else if value.translation.width < 0{
                            showTimesColumn = false
                        }
                    }
                }
        )
    
    }
    
    func timeLabel(time: String) -> some View {
        Group {
            if showTimesColumn {
                Text(time)
                    .rotationEffect(Angle(degrees: 90))
            } else {
                EmptyView()
            }
        }
    }

    
    var daySections: some View {
        ForEach(0..<5) { index in
            TimeTableUnit(CourseName: "資料庫", CoursePlace: "TR-313", BackFrameColor: .white)
            
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
        NavigationStack{
            SchoolTimeTable()
        }
    }
}
