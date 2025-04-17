//
//  ContentView.swift
//  Moonshot
//
//  Created by Bon Champion on 7/15/24.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showGrid = true
    
    var body: some View {
        
        NavigationStack {
            Group {
                if showGrid {
                    MainGridView(missions: missions, astronauts: astronauts)
                } else {
                    MainListView(missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .scrollContentBackground(.hidden)
            .navigationDestination(for: Mission.self) { selection in
                    MissionView(mission: selection, astronauts: astronauts)
            }
            .toolbar {
                Button {
                    withAnimation {
                        showGrid.toggle()
                    }
                } label: {
                    Image(systemName: showGrid ? "list.star" : "square.grid.2x2.fill")
                }
                .accessibilityLabel( showGrid ? "Toggle to list view" : "Toggle to grid view")
            }
        }
        
        
    }
}

#Preview {
    ContentView()
}
