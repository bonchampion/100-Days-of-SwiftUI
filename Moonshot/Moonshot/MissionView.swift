//
//  MissionView.swift
//  Moonshot
//
//  Created by Bon Champion on 7/19/24.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let astronauts: [String: Astronaut]
    
    var body: some View {
        ScrollView {
            VStack {
                Image(decorative: mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                
                VStack(alignment: .leading) {
                    
                    Text("Launch Date: \(mission.formattedLaunchDate)")
                        .padding(.top)
                        .monospaced()
                    
                    LightDivider()
                    
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                        .monospaced()
                    
                    Text(mission.description)
                        .opacity(0.75)
                    
                    LightDivider()
                    
                    Text("Mission Crew")
                        .font(.headline.bold())
                        .monospaced()
                        .padding(.bottom)
                }
                .padding(.horizontal)
                
                AstronautsScrollView(mission: mission, astronauts: astronauts)
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return  MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
