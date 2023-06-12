//
//  MainView.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/11.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        Group{
            AllTab
        }
    }
    var AllTab: some View{
        TabView{
            HomeView()
                .tabItem {
                    Label("首頁", systemImage: "house")
                }
            MoodleHome()
                .tabItem {
                    Label("Moodle", systemImage: "book")
                }
            LoadBulletinView()
                .tabItem{
                    Label("公布欄", systemImage: "newspaper")
                }
            SettingView()
                .tabItem {
                    Label("設定", systemImage: "gearshape")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
