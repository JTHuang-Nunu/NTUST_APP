import SwiftUI
import UIKit

struct Announcement: Identifiable {
    let id = UUID()
    var title: String
    var time: String
    var content: String
}

struct BulletinView: View {
    @State private var searchText = ""
    let announcements: [Announcement] = [
        Announcement(title: "公告1", time: "2023-06-12 10:00", content: "這是公告1的內容。"),
        Announcement(title: "公告2", time: "2023-06-11 15:30", content: "這是公告2的內容。"),
        Announcement(title: "公告3", time: "2023-06-10 09:45", content: "這是公告3的內容。")
    ]

    var filteredAnnouncements: [Announcement] {
        if searchText.isEmpty {
            return announcements
        } else {
            return announcements.filter { announcement in
                let announcementText = "\(announcement.title) \(announcement.time) \(announcement.content)"
                return announcementText.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                    .padding(.horizontal)

                List(filteredAnnouncements) { announcement in
                    NavigationLink(destination: AnnouncementContentView(announcement: announcement)) {
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
    }
}

struct AnnouncementContentView: View {
    let announcement: Announcement

    var body: some View {
        ScrollView {
            VStack {
                Text(announcement.title)
                    .font(.title)
                    .padding()

                Text(announcement.time)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding()

                Text(announcement.content)
                    .font(.body)
                    .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
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
        BulletinView()
    }
}
