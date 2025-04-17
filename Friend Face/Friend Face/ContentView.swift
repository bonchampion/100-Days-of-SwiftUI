//
//  ContentView.swift
//  Friend Face
//
//  Created by Bon Champion on 1/28/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \User.name) private var users: [User]
    
    var body: some View {
        NavigationStack {
            List(users) { user in
                NavigationLink(value: user) {
                    HStack {
                        Circle()
                            .fill(user.isActive ? .green : .red)
                            .frame(width: 10)
                        
                        Text(user.name)
                    }
                }
            }
            .navigationTitle("Friend Face")
            .navigationDestination(for: User.self) { user in
                UserView(user: user)
            }
            .task {
                await fetchUsers()
            }
        }
    }
    
    func fetchUsers() async {
        // Don't re-fetch data if we already have it.
        guard users.isEmpty else { return }
        
        do {
            let url = URL(string: "https://hws.dev/friendface.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let downloadedUsers = try decoder.decode([User].self, from: data)
            let insertContext = ModelContext(modelContext.container)
            
            for user in downloadedUsers {
                insertContext.insert(user)
            }
            
            try insertContext.save()
        } catch {
            print("Download failed.")
        }
    }
}

#Preview {
    ContentView()
}
