//
//  ContentView.swift
//  Navigation
//
//  Created by Bon Champion on 7/23/24.
//

import SwiftUI


struct ContentView: View {
    @State private var title = "SwiftUI"
    
    var body: some View {
        NavigationStack {
            List(0..<100) { i in
                Text("Row \(i)")
            }
            .navigationTitle($title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
