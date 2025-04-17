//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Bon Champion on 9/6/24.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
