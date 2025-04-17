//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Bon Champion on 11/22/24.
//

import SwiftData
import SwiftUI

struct UsersView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    
    var body: some View {
        List(users) { user in
            HStack {
                Text(user.name)

                Spacer()

                Text(String(user.jobs.count))
                    .fontWeight(.black)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
        }
        .onAppear(perform: addSample)
    }
    
    init(minumumJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= minumumJoinDate
        }, sort: sortOrder)
    }
    
    func addSample() {
        let user1 = User(name: "Billy Preston", city: "New York", joinDate: .now)
        let job1 = Job(name: "Organize sock drawer", priority: 3)
        let job2 = Job(name: "Make plans with Alex", priority: 4)

        modelContext.insert(user1)

        user1.jobs.append(job1)
        user1.jobs.append(job2)
    }
}

#Preview {
    UsersView(minumumJoinDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
