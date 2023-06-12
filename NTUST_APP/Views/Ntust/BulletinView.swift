//
//  Bulletin.swift
//  NTUST_APP
//
//  Created by Jimmy on 2023/6/12.
//

import SwiftUI

struct Announcement: Identifiable {
    let id = UUID()
    let title: String
    let time: String
    let content: String
}

struct BulletinView: View {
    @State private var isShowingContent = false
    let announcements: [Announcement] = [
        Announcement(title: "公告1", time: "2023-06-12 10:00", content: "這是公告1的內容。"),
        Announcement(title: "公告2", time: "2023-06-11 15:30", content: "這是公告2的內容。"),
        Announcement(title: "公告3", time: "2023-06-10 09:45", content: "這是公告3的內容。")
    ]
    
    var body: some View {
        NavigationView {
            List(announcements) { announcement in
                VStack(alignment: .leading) {
                    Text(announcement.title)
                        .font(.headline)
                    Text(announcement.time)
                        .font(.subheadline)
                    Button(action: {
                        isShowingContent = true
                    }) {
                        Text("查看內文")
                    }
                }
            }
            .navigationTitle("公布欄")
        }
        .sheet(isPresented: $isShowingContent) {
            AnnouncementContentView(isPresented: $isShowingContent)
        }
    }
}

struct AnnouncementContentView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Text("內文")
                .font(.title)
                .padding()
            
            Text("這是公告內文的詳細內容。")
                .padding()
            
            Button(action: {
                isPresented = false
            }) {
                Text("關閉")
                    .font(.headline)
            }
            .padding()
        }
    }
}

struct Bulletin_Previews: PreviewProvider {
    static var previews: some View {
        BulletinView()
    }
}
