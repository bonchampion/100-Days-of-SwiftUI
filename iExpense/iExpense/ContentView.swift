//
//  ContentView.swift
//  iExpense
//
//  Created by Bon Champion on 7/10/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var showingType = "All"
    @State private var sortOrder = [
        SortDescriptor(\Expense.name),
        SortDescriptor(\Expense.amount, order: .reverse)
    ]
    
    var body: some View {
        NavigationStack {
            ExpensesList(type: showingType, sortOrder: sortOrder)
                .navigationTitle("iExpense")
                .toolbar {
                    NavigationLink {
                        AddView()
                    } label: {
                        Label("Add Expense", systemImage: "plus")
                    }
                    
                    Menu("Filter", systemImage: "line.3.horizontal.decrease.circle") {
                        Picker("Filter", selection: $showingType) {
                            Text("Show All")
                                .tag("All")
                            
                            Divider()
                            
                            ForEach(AddView.types, id: \.self) { type in
                                Text(type)
                                    .tag(type)
                            }
                        }
                    }
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down"){
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Name")
                                .tag([
                                    SortDescriptor(\Expense.name),
                                    SortDescriptor(\Expense.amount, order: .reverse)
                                ])
                            
                            Text("Sort by Amount")
                                .tag([
                                    SortDescriptor(\Expense.amount, order: .reverse),
                                    SortDescriptor(\Expense.name)
                                ])
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Expense.self)
}
