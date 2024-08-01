//
//  ContentView.swift
//  Habit Tracker
//
//  Created by Bon Champion on 8/1/24.
//

import SwiftUI

struct ContentView: View {
    @State private var data = Activities()
    @State private var addingNewActivity = false
    
    var body: some View {
        NavigationStack {
            List(data.items) { activity in
                NavigationLink {
                    ActivityView(data: data, activity: activity)
                } label: {
                    HStack {
                        HStack {
                            Text(activity.name)
                            if (activity.count > 0 && Calendar.current.isDateInToday(activity.lastUpdated)){
                                Image(systemName: "checkmark.circle")
                            }
                        }
                        Spacer()
                        Text("\(activity.count)")
                            .font(.caption.weight(.black))
                            .padding(5)
                            .frame(minWidth: 50)
                            .background(.black.opacity(0.7))
                            .foregroundStyle(.white)
                            .clipShape(.capsule)
                    }
                }
                .listRowBackground(activity.count > 0 && Calendar.current.isDateInToday(activity.lastUpdated) ? Color.successGreen : Color.white)
            }
            .navigationTitle("Your habits")
            .toolbar {
                Button {
                    addingNewActivity.toggle()
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add new activity")
                    }
                }
            }
            .sheet(isPresented: $addingNewActivity) {
                AddActivity(data: data)
            }
            .navigationDestination(for: Activity.self) { selection in
                ActivityView(data: data, activity: selection)
            }
        }
        
    }
}

#Preview {
    ContentView()
}
