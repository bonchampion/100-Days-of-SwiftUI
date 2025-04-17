//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Bon Champion on 11/21/24.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
