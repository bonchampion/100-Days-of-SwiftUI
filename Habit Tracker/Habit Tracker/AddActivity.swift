//
//  AddActivity.swift
//  Habit Tracker
//
//  Created by Bon Champion on 8/1/24.
//

import SwiftUI

struct AddActivity: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var description = ""
    
    var data: Activities
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Name"){
                    TextField("Name", text: $name, prompt: Text("My new activity"))
                }
                Section("Description"){
                    TextEditor(text: $description)
                }
            }
            .navigationTitle("New activity")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let trimmedName = name.trimmingCharacters(in: .whitespaces)
                        guard trimmedName.isEmpty == false else { return }
                        
                        let item = Activity(name: trimmedName, description: description)
                        data.items.append(item)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    AddActivity(data: Activities())
}
