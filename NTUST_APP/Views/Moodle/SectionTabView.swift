//
//  SectionView.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/9.
//

import SwiftUI

struct SectionTabView: View {
    var coursePage: CoursePage
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(coursePage.week_list, id: \.week) { week in
                    WeekView(week: week)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct WeekView: View {
    let week: CourseWeek
    
    var body: some View {
        VStack {
            Text(week.week)
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
}

struct SectionRowView: View {
    let section: CourseSection
    
    var body: some View {
        HStack {
            Image(systemName: "book")
                .font(.title)
            
            Text(section.name)
                .font(.headline)
            
            Spacer()
            
            Button(action: {
                // Handle button action
            }) {
                Text("Open")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
        }
    }
}


struct SectionTabView_Previews: PreviewProvider {
    static var previews: some View {
        SectionTabView(coursePage: sampleCoursePage)
    }
}

let sampleCoursePage = CoursePage(
    week_list: [
        CourseWeek(
            section: [
                CourseSection(icon_url: "book", name: "Introduction to Swift", url: "https://example.com/course/1"),
                CourseSection(icon_url: "video", name: "SwiftUI Basics", url: "https://example.com/course/2")
            ],
            week: "Week 1"
        ),
        CourseWeek(
            section: [
                CourseSection(icon_url: "doc.text", name: "Working with Views", url: "https://example.com/course/3"),
                CourseSection(icon_url: "play", name: "Animations in SwiftUI", url: "https://example.com/course/4"),
                CourseSection(icon_url: "camera", name: "Using Camera in SwiftUI", url: "https://example.com/course/5")
            ],
            week: "Week 2"
        )
    ]
)
