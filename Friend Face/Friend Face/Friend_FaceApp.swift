//
//  Friend_FaceApp.swift
//  Friend Face
//
//  Created by Bon Champion on 1/28/25.
//

import SwiftData
import SwiftUI

@main
struct Friend_FaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
