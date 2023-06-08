//
//  SectionView.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/9.
//

import SwiftUI

struct SectionTabView: View {
    var courseWeekInfos: [CourseWeekInfo]
    var body: some View {
        infoDisplay
    }
    
    var infoDisplay: some View{
        Group{
            if courseWeekInfos.count == 0 {
                Text("沒有任何課程資訊哦")
            }
            else{
                ScrollView{
                    ForEach(courseWeekInfos, id: \.week){ courseWeekInfo in
                        VStack(alignment: .leading){
                            Text(courseWeekInfo.week)
                                .font(.title)
                                .bold()
                                .padding(.leading)
                            ForEach(courseWeekInfo.weekItems, id: \.name){ weekItemInfo in
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    
}

struct SectionTabView_Previews: PreviewProvider {
    static var previews: some View {
        SectionTabView(courseWeekInfos: [])
    }
}
struct CourseWeekInfo{
    var week: String
    var weekItems: [WeekItemInfo]
    
}
struct WeekItemInfo{
    var name: String
    var url: String
}
