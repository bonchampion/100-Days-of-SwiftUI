//
//  MainListView.swift
//  Moonshot
//
//  Created by Bon Champion on 7/22/24.
//

import SwiftUI

struct MainListView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink(value: mission, label: {
                    HStack {
                        Text(mission.displayName)
                            .foregroundStyle(.white)
                        
                        Spacer()
                        
                        Text(mission.formattedLaunchDate)
                            .foregroundStyle(.gray)
                            .accessibilityLabel(mission.formattedLaunchDate == "N/A" ? "Not launched" : "Launched on \(mission.formattedLaunchDate)")
                    }
                    .frame(maxWidth:.infinity, alignment:.topLeading)
                })
                .listRowBackground(Color.lightBackground)
                .listRowSeparatorTint(.black)
                .padding(.vertical, 10)
            }
        }
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    return MainListView(missions: missions, astronauts: astronauts)
}
