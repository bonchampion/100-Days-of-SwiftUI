//
//  UserView.swift
//  Friend Face
//
//  Created by Bon Champion on 1/29/25.
//

import SwiftData
import SwiftUI

struct UserView: View {
    let user: User
    
    var body: some View {
        List {
            Section("About") {
                Text(user.about)
            }
            Section("Details") {
                if user.isActive {
                    HStack {
                        Circle()
                            .fill(user.isActive ? .green : .red)
                            .frame(width: 10)
                        
                        Text("Online now")
                    }
                }
                Text("Age: " + String(user.age))
                Text("Address: " + user.address)
            }
            Section("Friends") {
                ForEach(user.friends) { friend in
                    Text(friend.name)
                }
            }
        }
        .navigationTitle(user.name)
        .listStyle(.grouped)
    }
}

#Preview {
    UserView(user: .example)
}
