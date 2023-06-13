//
//  SectionView.swift
//  NTUST_APP
//
//  Created by Cheng Pong Huang on 2023/6/9.
//

import SwiftUI

struct SectionTabView: View {
    var coursePage: CoursePage
    
    var body: some View {
        List {
            Group {
                ForEach(coursePage.week_list, id: \.week) { week in
                    WeekView(week: week)
                        .padding()
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct WeekView: View {
    let week: CourseWeek
    
    var body: some View {
        Section {
            Text(week.week)
                .font(.title2)
                .fontWeight(.bold)
            
            ForEach(week.section, id: \.name) { section in
                SectionRowView(section: section)
            }
        }
    }
}

struct SectionRowView: View {
    let section: CourseSection
    let StrIconMap: [String: String] = [
        "pdf": "doc.text.fill",
        "forum" : "bubble.left",
        "core" : "arrow.down.doc",
        "assign" : "square.and.pencil",
    ]
    
    @State private var isDownloading = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var fileURL: URL?
    @State private var isShowingPreview = false
    
    var body: some View {
        ZStack {
            HStack {
                Image(systemName: GetIcon())
                    .font(.title3)
                
                Text(section.name)
                    .font(.title3)
                
                Spacer()
                
                Button(action: {
                    print(section.icon_url)
                    if section.icon_url.contains("pdf") {
                        self.isDownloading = true
                        MoodleManager.shared.GetCoursePageResourceFile(section.url) { (success, url) in
                            self.isDownloading = false
                            if success {
                                DispatchQueue.main.async {
                                    print("文件成功下载！")
                                    self.fileURL = url
                                    if let url = self.fileURL {
                                        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                           let window = scene.windows.first {
                                            let viewController = UIHostingController(rootView: DocumentPreview(url: url))
                                            let navigationController = UINavigationController(rootViewController: viewController)
                                            window.rootViewController?.present(navigationController, animated: true)
                                        }
                                    }
                                }
                            } else {
                                DispatchQueue.main.async {
                                    self.showAlert = true
                                    self.alertMessage = "文件下载失败： \(String(describing: url))"
                                }
                            }
                        }
                    } else {
                        self.showAlert = true
                        self.alertMessage = "我們現在不提供這個服務"
                    }
                }) {
                    Text("Open")
                        .font(.title3)
                        .foregroundColor(.blue)
                }.disabled(isDownloading)
            }
            .blur(radius: isDownloading ? 3 : 0)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("錯誤"), message: Text(alertMessage), dismissButton: .default(Text("好")))
            }
            
            if isDownloading {
                ProgressView()
                    .scaleEffect(2)
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.45))
            }
        }
    }
    
    func GetIcon() -> String {
        for (key, value) in StrIconMap {
            if section.icon_url.contains(key) {
                return value
            }
        }
        return "square.and.pencil"
    }
}



struct SectionTabView_Previews: PreviewProvider {
    static var previews: some View {
        SectionTabView(coursePage: testCoursePage)
    }
}


let testCoursePage = CoursePage(week_list: [
    CourseWeek(section: [CourseSection(icon_url: "https://moodle2.ntust.edu.tw/theme/image.php/moove/forum/1659609679/icon", name: "公告 討論區", url: "https://moodle2.ntust.edu.tw/mod/forum/view.php?id=77838"), CourseSection(icon_url: "https://moodle2.ntust.edu.tw/theme/image.php/moove/core/1659609679/f/archive-24", name: "教室環境專案檔 檔案", url: "https://moodle2.ntust.edu.tw/mod/resource/view.php?id=89949")], week: "一般"),
    CourseWeek(section: [], week: "02月 20日 - 02月 26日"),
    CourseWeek(section: [CourseSection(icon_url: "https://moodle2.ntust.edu.tw/theme/image.php/moove/core/1659609679/f/pdf-24", name: "上課PPT 檔案", url: "https://moodle2.ntust.edu.tw/mod/resource/view.php?id=87472"), CourseSection(icon_url: "https://moodle2.ntust.edu.tw/theme/image.php/moove/core/1659609679/f/archive-24", name: "練習用素材 檔案", url: "https://moodle2.ntust.edu.tw/mod/resource/view.php?id=87474")], week: "02月 27日 - 03月 5日"),
    CourseWeek(section: [CourseSection(icon_url: "https://moodle2.ntust.edu.tw/theme/image.php/moove/core/1659609679/f/pdf-24", name: "上課PPT 檔案", url: "https://moodle2.ntust.edu.tw/mod/resource/view.php?id=89940"), CourseSection(icon_url: "https://moodle2.ntust.edu.tw/theme/image.php/moove/assign/1659609679/icon", name: "課堂練習 作業", url: "https://moodle2.ntust.edu.tw/mod/assign/view.php?id=89948")], week: "03月 6日 - 03月 12日"),
    CourseWeek(section: [CourseSection(icon_url: "https://moodle2.ntust.edu.tw/theme/image.php/moove/core/1659609679/f/pdf-24", name: "上課PPT 檔案", url: "https://moodle2.ntust.edu.tw/mod/resource/view.php?id=92156"), CourseSection(icon_url: "https://moodle2.ntust.edu.tw/theme/image.php/moove/assign/1659609679/icon", name: "課堂練習 作業", url: "https://moodle2.ntust.edu.tw/mod/assign/view.php?id=92157")], week: "03月 13日 - 03月 19日"),
    CourseWeek(section: [CourseSection(icon_url: "https://moodle2.ntust.edu.tw/theme/image.php/moove/core/1659609679/f/pdf-24", name: "上課PPT 檔案", url: "https://moodle2.ntust.edu.tw/mod/resource/view.php?id=94213"), CourseSection(icon_url: "https://moodle2.ntust.edu.tw/theme/image.php/moove/assign/1659609679/icon", name: "課堂練習 作業", url: "https://moodle2.ntust.edu.tw/mod/assign/view.php?id=94211")], week: "03月 20日 - 03月 26日"),
    CourseWeek(section: [CourseSection(icon_url: "https://moodle2.ntust.edu.tw/theme/image.php/moove/core/1659609679/f/pdf-24", name: "上課PPT 檔案", url: "https://moodle2.ntust.edu.tw/mod/resource/view.php?id=96252"), CourseSection(icon_url: "https://moodle2.ntust.edu.tw/theme/image.php/moove/assign/1659609679/icon", name: "課堂練習 作業", url: "https://moodle2.ntust.edu.tw/mod/assign/view.php?id=96253")], week: "03月 27日 - 04月 2日"),
    CourseWeek(section: [], week: "04月 3日 - 04月 9日"),
    CourseWeek(section: [CourseSection(icon_url: "https://moodle2.ntust.edu.tw/theme/image.php/moove/core/1659609679/f/pdf-24", name: "上課PPT 檔案", url: "https://moodle2.ntust.edu.tw/mod/resource/view.php?id=98772"), CourseSection(icon_url: "https://moodle2.ntust.edu.tw/theme/image.php/moove/assign/1659609679/icon", name: "課堂練習 作業", url: "https://moodle2.ntust.edu.tw/mod/assign/view.php?id=98773")], week: "04月 10日 - 04月 16日"),
    CourseWeek(section: [CourseSection(icon_url: "https://moodle2.ntust.edu.tw/theme/image.php/moove/core/1659609679/f/pdf-24", name: "上課PPT 檔案", url: "https://moodle2.ntust.edu.tw/mod/resource/view.php?id=100265"), CourseSection(icon_url: "https://moodle2.ntust.edu.tw/theme/image.php/moove/assign/1659609679/icon", name: "課堂練習 作業", url: "https://moodle2.ntust.edu.tw/mod/assign/view.php?id=100266")], week: "04月 17日 - 04月 23日"),
    CourseWeek(section: [], week: "04月 24日 - 04月 30日"),
    CourseWeek(section: [], week: "05月 1日 - 05月 7日"),
    CourseWeek(section: [], week: "05月 8日 - 05月 14日"),
    CourseWeek(section: [], week: "05月 15日 - 05月 21日"),
    CourseWeek(section: [], week: "05月 22日 - 05月 28日"),
    CourseWeek(section: [], week: "05月 29日 - 06月 4日"),
    CourseWeek(section: [], week: "06月 5日 - 06月 11日"),
    CourseWeek(section: [], week: "06月 19日 - 06月 25日")])
