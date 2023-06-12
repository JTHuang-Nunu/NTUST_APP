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
    
    var AvatarIcon: some View{
        Button{
            isPresented = true
        }label: {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .padding()
        }
    }
    let columns = Array(repeating: GridItem(.adaptive(minimum: 200)), count: 2)
    var CardGrid: some View{
        ZStack{
            ScrollView{
                Grid{
                    ForEach(Array(CardGridMap.keys), id: \.self) { key in
                        if let card1 = CardGridMap[key]?.0, let card2 = CardGridMap[key]?.1 {
                            GridRow {
                                NavigationLink(destination: card2) {
                                    card1
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    let CardGridMap: [String: (AnyView, AnyView)] = [
        "學校地圖": (AnyView(Card(IconName: "map", Title: "學校地圖")), AnyView(MapView())),
        "成績": (AnyView(Card(IconName: "book", Title: "成績")), AnyView(ScoreView(scores: [])))
    ]

        
    
    //處理按鈕點擊
    func handleCardTap(_ title: String) {
        print("Card tapped: \(title)")
        switch title {
        case "Home":
            print("Handle Home action here")
        case "Course":
            print("Handle Course action here")
        case "Calendar":
            print("Handle Calendar action here")
        case "Club":
            print("Handle Club action here")
        case "Teacher":
            print("Handle Teacher action here")
        case "Student":
            print("Handle Student action here")
        case "Test":
            print("Handle Test action here")
            
            for sno in ntust_sno {
                YouBikeManager.shared.GetBikeStationBySno(sno: sno) { station in
                    if let station = station {
                        // 存取成功，找到了符合站點代號的站點資料
                        print("站點名稱：\(station.sna)")
                        print("站點總停車格：\(station.tot)")
                        print("目前可用車輛數量：\(station.sbi)")
                        print("空位數量:\(station.bemp)")
                    } else {
                        // 存取失敗或找不到符合站點代號的站點資料
                        print("存取失敗或找不到該站點")
                    }
                }
            }
            

            
        default:
            print("Unknown title")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
