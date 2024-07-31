//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Bon Champion on 6/16/24.
//

import SwiftUI

struct SpecialTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundStyle(.gray)
            .padding()
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 10))
    }
}

extension View {
    func special() -> some View {
        modifier(SpecialTitle())
    }
}

struct ContentView: View {
    @State private var useRedText = false

    var body: some View {
        Button("Hello World") {
            // flip the Boolean between true and false
            useRedText.toggle()
        }
        .foregroundStyle(useRedText ? .red : .blue)
        
        Text("Bon's App")
            .special()
    }
}

#Preview {
    ContentView()
}
