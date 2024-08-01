//
//  ActivityView.swift
//  Habit Tracker
//
//  Created by Bon Champion on 8/1/24.
//

import SwiftUI

struct ActivityView: View {
    @Environment(\.dismiss) var dismiss
    
    var data: Activities
    var activity: Activity
    
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(activity.description)
                    .padding(.bottom, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("You've done this ^[\(activity.count) times](inflect: true).")
                    .padding(.bottom, 20)
                    .bold()
                Button("Log a ^[\(activity.name)](inflect: true)") {
                    var newActivity = activity
                    newActivity.count += 1
                    newActivity.lastUpdated = Date.now
                    if let index = data.items.firstIndex(of: activity) {
                        data.items[index] = newActivity
                    }
                }
                .buttonStyle(BorderedProminentButtonStyle())
            }
            .frame(maxWidth: .infinity)
            .navigationTitle(activity.name)
            .navigationBarTitleDisplayMode(.large)
            .padding()
        }
        .background(Color(red: 0.95, green: 0.95, blue: 0.97), ignoresSafeAreaEdges: .all)
        .toolbar {
            Button("Delete", role: .destructive) {
                showingDeleteAlert = true
            }
        }
        .alert("Are you sure?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive){
                if let index = data.items.firstIndex(of: activity) {
                    data.items.remove(at: index)
                    dismiss()
                }
            }
        } message: {
            Text("This activity will be deleted entirely.")
        }
    }
}

#Preview {
    return ActivityView(data: Activities(), activity: .example)
}
