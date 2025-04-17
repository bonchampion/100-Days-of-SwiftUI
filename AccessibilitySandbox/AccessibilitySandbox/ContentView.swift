//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Bon Champion on 3/28/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Button("John Fitzgerald Kennedy") {
            print("Button tapped")
        }
        .accessibilityInputLabels(["John Fitzgerald Kennedy", "Kennedy", "JFK"])
    }
}

#Preview {
    ContentView()
}
