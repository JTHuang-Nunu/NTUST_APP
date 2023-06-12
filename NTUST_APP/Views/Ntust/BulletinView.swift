import SwiftUI
import UIKit
import SafariServices

struct Announcement: Identifiable {
    let id = UUID()
    var title: String
    var time: String
    var url: URL
}

struct LoadBulletinView: View{
    
    @State var announcements: [Announcement]? = nil
    
    var body: some View{
        NavigationStack {
            VStack{
                if let announcements = announcements{
                    BulletinView(announcements: announcements)
                }
                else{
                    ProgressView()
                }
            }
            .task{
                loadAnnouncements()
            }
            .navigationTitle("公布欄")
        
        }
    }
    
    func loadAnnouncements(){
        NTUSTSystemManager.shared.GetNtustBulletinBoard{ success, news in
            if success{
                var announcements: [Announcement] = []
                for i in 0..<news.count{
                    announcements.append(Announcement(title: news[i].title, time: news[i].date, url: URL(string: news[i].url)!))
                }
                self.announcements = announcements.reversed()
            }else{
                print("公告載入失敗")
                announcements = nil
            }
        }
    }
    
}

struct BulletinView: View {
    @State private var searchText = ""
    @State var announcements: [Announcement]
    @State var showSafari: Bool = false
    @State var url: URL? = URL(string: "https://www.ntust.edu.tw/")!

    var filteredAnnouncements: [Announcement] {
        if searchText.isEmpty {
            return announcements
        } else {
            return announcements.filter { announcement in
                let announcementText = "\(announcement.title) \(announcement.time) \(announcement.url)"
                return announcementText.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        Group {
            VStack {
                SearchBar(text: $searchText)
                    .padding(.horizontal)

                List(filteredAnnouncements) { announcement in
                    Button{
                        url = announcement.url
                        // wait 0.1s and show safari
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            showSafari = true
                        }
                    } label: {
                        VStack(alignment: .leading) {
                            Text(announcement.title)
                                .font(.title2)
                                .foregroundColor(.primary)

                            Text(announcement.time)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.vertical, 8)
                }
                .navigationTitle("公布欄")
            }
        }
        .fullScreenCover(isPresented: $showSafari, content: {
            if url != nil{
                SFSafariViewWrapper(url: url!)
            }
            else{
                Text("網址錯誤")
                    .font(.title)
                    .padding()
                Button("關閉"){
                    showSafari = false
                }
            
            }
        })
    }
}



struct SearchBar: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        let searchBar: UISearchBar

        init(text: Binding<String>, searchBar: UISearchBar) {
            _text = text
            self.searchBar = searchBar
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, searchBar: UISearchBar())
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = context.coordinator.searchBar
        searchBar.delegate = context.coordinator
        searchBar.showsCancelButton = true
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}

struct Bulletin_Previews: PreviewProvider {
    static var previews: some View {
        BulletinView(announcements: [])
    }
}


struct SFSafariViewWrapper: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SFSafariViewWrapper>) {
        return
    }
}
