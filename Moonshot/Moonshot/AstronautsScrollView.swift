//
//  AstronautsScrollView.swift
//  Moonshot
//
//  Created by Bon Champion on 7/22/24.
//

import SwiftUI

struct AstronautsScrollView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink(value: crewMember.astronaut, label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(.capsule)
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                    .monospaced()
                                Text(crewMember.role)
                                    .foregroundStyle(.white)
                                    .opacity(0.75)
                            }
                        }
                        .padding(.horizontal)
                    })
                }
            }
        }
        .navigationDestination(for: Astronaut.self) { selection in
            AstronautView(astronaut: selection)
        }
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return  AstronautsScrollView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}

