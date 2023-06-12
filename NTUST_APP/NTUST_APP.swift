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
    @State private var isLoggedIn = false

    var body: some Scene {
        WindowGroup {
            MapView()
        }
    }
}

