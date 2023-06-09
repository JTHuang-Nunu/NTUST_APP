//
//  MainView.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/5/31.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack{
            Title
            Spacer()
            CardGrid
        }
    }
    var Title: some View{
        HStack{
            Text("台科生活")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            Spacer()
            // Icon of Avatar
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .padding()
        
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
//            NTUSTSystemManager.shared.Login(Account: "B10915003", Password: "A9%t376149") { success in
//                if success {
//                    // 登入成功
//                    print("Login successful")
//                } else {
//                    // 登入失敗
//                    print("Login failed")
//                }
//            }
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
