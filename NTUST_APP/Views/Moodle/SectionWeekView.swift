//
//  SectionWeekView.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/11.
//

import SwiftUI

struct SectionWeekView: View {
    let courseWeek: CourseWeek
    var body: some View {
        VStack {
            Text(courseWeek.week)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            ForEach(week.section, id: \.name) { section in
                SectionRowView(section: section)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
            }
    }
}

struct SectionWeekView_Previews: PreviewProvider {
    static var previews: some View {
        SectionWeekView(courseWeek: CourseWeek(section: [], week: "17週"))
    }
}
