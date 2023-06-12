//
//  MainView.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/5/31.
//

import SwiftUI

//NTUST 附近的站點
var ntust_sno:[String] = ["500101024", "500101025", "500101026", "500101027", "500101028"]

/*
 "sno": "500101024",
 "sna": "YouBike2.0_臺灣科技大學正門",

 "sno": "500101025",
 "sna": "YouBike2.0_臺灣科技大學側門",

 "sno": "500101026",
 "sna": "YouBike2.0_公館公園",

 "sno": "500101027",
 "sna": "YouBike2.0_臺灣科技大學後門",

 "sno": "500101028",
 "sna": "YouBike2.0_臺大醫學院附設癌醫中心",
 */


struct HomeView: View {
    @State var isPresented = false
    
    var body: some View {
        NavigationStack{
            VStack{
                CardGrid
            }
            .navigationTitle("Home")
            .sheet(isPresented: $isPresented, content: {
                Text("Profile")
            })
            
        }
    }
    let columns = Array(repeating: GridItem(.adaptive(minimum: 200)), count: 2)
    var CardGrid: some View{
        ZStack{
            ScrollView{
                Grid{
                    ForEach(0..<CardGridMap.count){ i in
                        GridRow{
                            ForEach(0..<CardGridMap[i].count){ j in
                                NavigationLink(destination: CardGridMap[i][j].1){
                                    CardGridMap[i][j].0
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        
    }
    let CardGridMap: [[(AnyView, AnyView)]] =
    [
        [
        (AnyView(Card(IconName: "map", Title: "學校地圖")), AnyView(MapView())),
        (AnyView(Card(IconName: "book", Title: "成績")), AnyView(ScoreView()))
        ],
        [
        (AnyView(Card(IconName: "bicycle", Title: "YouBike資訊")), AnyView(MapView())),
        (AnyView(Card(IconName: "calendar", Title: "課表")), AnyView(SchoolTimeTable()))
        ],
    ]


}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
