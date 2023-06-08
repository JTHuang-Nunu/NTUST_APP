//
//  MoodleHome.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/8.
//

import SwiftUI

struct MoodleHome: View {
    var body: some View {
        NavigationStack{
            CourseList
        }
    }
    var CourseList: some View{
        VStack(spacing: 50){
            CourseCard(CourseName: "資料庫")
            CourseCard(CourseName: "資料庫")
            CourseCard(CourseName: "資料庫")
        }
    }

}

struct MoodleHome_Previews: PreviewProvider {
    static var previews: some View {
        MoodleHome()
    }
}
