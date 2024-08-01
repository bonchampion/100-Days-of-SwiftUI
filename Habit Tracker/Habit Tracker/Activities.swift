//
//  Activities.swift
//  Habit Tracker
//
//  Created by Bon Champion on 8/1/24.
//

import Foundation

@Observable
class Activities {
    var items = [Activity]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.setValue(encoded, forKey: "Activities")
            }
        }
    }
    
    init() {
        if let saved = UserDefaults.standard.data(forKey: "Activities") {
            if let decoded = try? JSONDecoder().decode([Activity].self, from: saved) {
                items = decoded
                return
            }
        }
        
        items = []
    }
}
