//
//  ErenaAdminApp.swift
//  ErenaAdmin
//
//  Created by Shoaib Akhtar on 30/09/25.
//

import SwiftUI
import FirebaseCore

@main
struct ErenaAdminApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
