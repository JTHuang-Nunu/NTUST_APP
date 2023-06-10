//
//  MainView.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/5/31.
//

import SwiftUI

struct HomeView: View {
    @State var isPresented = false
    
    var body: some View {
        NavigationView{
            VStack{
                CardGrid
                    
            }
            .overlay{
                NavigationBar(title: "Home")
            }
            .overlay{
                AvatarIcon
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            }.sheet(isPresented: $isPresented, content: {
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
                    
                    NavigationLink(destination: YoubikeView())           {
                            Card(IconName: "paperplane", Title: "Test"){
                                handleCardTap("Test")
                        }
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
