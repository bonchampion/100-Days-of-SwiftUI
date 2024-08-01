//
//  Activity.swift
//  Habit Tracker
//
//  Created by Bon Champion on 8/1/24.
//

import Foundation

struct Activity: Codable, Identifiable, Hashable, Equatable {
    var id = UUID()
    var name: String
    var description: String
    var count = 0
    var lastUpdated = Date.now
    
    static let example = Activity(name: "Example activity", description: "This is a test activity.")
}

