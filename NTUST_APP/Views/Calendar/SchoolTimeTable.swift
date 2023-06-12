//
//  SchoolTimeTable.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/1.
//

import SwiftUI

struct SchoolTimeTable: View {
    var weekdays = ["星期一", "星期二", "星期三", "星期四", "星期五"]
    var times = ["08:10", "09:10", "10:20", "11:20", "12:20", "13:20", "14:20", "15:30", "16:30", "17:30", "18:25", "19:20", "20:15", "21:10"]
    @State private var showTimesColumn = false
    @State private var tableRows: [CourseTableRow]? = nil
    @StateObject private var ntustSystemManager = NTUSTSystemManager.shared
    @State private var showLoginView = false
    
        
    var body: some View {
        VStack {
            Group{
                if ntustSystemManager.login_status{
                    content
                }else{
                    NeedLoginView(RequireLoginType: .NTUST){
                        showLoginView = true
                    }
                }
            }
            .sheet(isPresented: $showLoginView){
                LoginView(loginType: .NTUST)
            }
            
            
        }
        .navigationTitle("課表")
        
    }
    var content: some View{
        Group {
            if tableRows == nil {
                ProgressView()
            } else {
                ScrollView {
                    getTimeTable(tableRows: tableRows!)
                        .padding()
                        
                }
            }
        }
        .task{
            loadTimeTables()
        }
        
    }
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

    
    func loadTimeTables(){
        NTUSTSystemManager.shared.GetNtustCourseTable{success, table in
            if success{
                self.tableRows = table
                print(table)
            }else{
                print("Error loading time table")
                self.tableRows = nil
            
            }
        }
    }
    func getTimeTable(tableRows: [CourseTableRow]) -> some View{
        return Grid {
            weekBar
            ForEach(0..<tableRows.count){ i in
                GridRow {
                    timeLabel(time: times[i])
                    TableRow(row: tableRows[i])
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
}

struct TableRow: View{
    let row: CourseTableRow
    var body: some View{
        let courses: [String] = [
            row.Monday,
            row.Tuesday,
            row.Wednesday,
            row.Thursday,
            row.Friday
        ]
        ForEach(0..<5) { i in
            let (sectionName, placeName) = parseCourseFullName(fullName: courses[i])
            TimeTableUnit(CourseName: sectionName, CoursePlace: placeName, BackFrameColor: .white)
        }
    }
    func parseCourseFullName(fullName: String) -> (courseName: String, classroom: String) {
        let pattern = #"([A-Za-z]{2}-\d+)"#
        
        if let range = fullName.range(of: pattern, options: .regularExpression) {
            let courseName = fullName[..<range.lowerBound].trimmingCharacters(in: .whitespacesAndNewlines)
            let classroom = fullName[range].trimmingCharacters(in: .whitespacesAndNewlines)
            return (courseName, classroom)
        }
        
        return ("", "")
    }

}

struct SchoolTimeTable_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SchoolTimeTable()
        }
    }
}
