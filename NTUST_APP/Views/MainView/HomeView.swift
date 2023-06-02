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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
