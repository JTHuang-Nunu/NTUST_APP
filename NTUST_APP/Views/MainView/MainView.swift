//
//  MainView.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/3.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            SettingView()
                .tabItem {
                    Label("Setting", systemImage: "gearshape")
                }
        
        }
    }
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    var CardGrid: some View{
        ZStack{
            ScrollView{
                LazyVGrid(columns: columns){
                    Card(IconName: "house", Title: "Home"){
                        handleCardTap("Home")
                    }
                    Card(IconName: "book", Title: "Course"){
                        handleCardTap("Course")
                    }
                    Card(IconName: "calendar", Title: "Calendar"){
                        handleCardTap("Calendar")
                    }
                    Card(IconName: "person.3", Title: "Club"){
                        handleCardTap("Club")
                    }
                    Card(IconName: "person", Title: "Teacher"){
                        handleCardTap("Teacher")
                    }
                    Card(IconName: "person.2", Title: "Student"){
                        handleCardTap("Student")
                    }
                    Card(IconName: "paperplane", Title: "Test"){
                        handleCardTap("Test")
                    }
                }
            }
        }
    }
    
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
            NTUSTSystemManager.shared.Test()
        default:
            print("Unknown title")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
