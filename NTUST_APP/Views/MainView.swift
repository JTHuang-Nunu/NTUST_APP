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
    let columns = Array(repeating: GridItem(.flexible()), count: 2)
    var CardGrid: some View{
        ZStack{
            ScrollView{
                LazyVGrid(columns: columns){
                    Card(IconName: "house", Title: "Home")
                    Card(IconName: "book", Title: "Course")
                    Card(IconName: "calendar", Title: "Calendar")
                    Card(IconName: "person.3", Title: "Club")
                    Card(IconName: "person", Title: "Teacher")
                    Card(IconName: "person.2", Title: "Student")
                }
            }
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
