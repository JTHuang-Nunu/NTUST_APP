//
//  NTUST_APPApp.swift
//  NTUST_APP
//
//  Created by mac03 on 2023/5/11.
//

import SwiftUI

@main
struct NTUST_APP: App {
    let persistenceController = PersistenceController.shared
    @State private var isLoggedIn = true

    var body: some Scene {
        WindowGroup {
            NavigationView {
                if isLoggedIn {
                    MainView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                } else {
                    LoginView(isLoggedIn: $isLoggedIn)
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                }
            }
        }
    }
}

