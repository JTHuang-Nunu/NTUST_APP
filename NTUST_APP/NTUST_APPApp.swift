//
//  NTUST_APPApp.swift
//  NTUST_APP
//
//  Created by mac03 on 2023/5/11.
//

import SwiftUI

@main
struct NTUST_APPApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
