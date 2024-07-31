//
//  ContentView.swift
//  iExpense
//
//  Created by Bon Champion on 7/10/24.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.setValue(encoded, forKey: "Items")
            }
        }
    }
    
    var personalItems: [ExpenseItem] {
        items.filter { $0.type == "Personal" }
    }
    
    var businessItems: [ExpenseItem] {
        items.filter { $0.type == "Business" }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    
    var body: some View {
        NavigationStack {
            List {
                Section("Personal Items") {
                    ForEach(expenses.personalItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundStyle(item.amount > 100 ? .red : .black)
                                .fontWeight(item.amount > 100 ? .bold : .regular)
                                .italic(item.amount < 10 ? true : false)
                        }
                    }
                    .onDelete(perform: removePersonalItems)
                }
                Section("Business Items") {
                    ForEach(expenses.businessItems) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundStyle(item.amount > 100 ? .red : .black)
                                .fontWeight(item.amount > 100 ? .bold : .regular)
                                .italic(item.amount < 10 ? true : false)
                        }
                    }
                    .onDelete(perform: removeBusinessItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink {
                    AddView(expenses: expenses)
                } label: {
                    Label("Add Expense", systemImage: "plus")
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    func removeBusinessItems(at offsets: IndexSet) {
        var objectsToDelete = IndexSet()
        
        for offset in offsets {
            let item = expenses.businessItems[offset]
            
            if let index = expenses.items.firstIndex(of: item) {
                objectsToDelete.insert(index)
            }
            
            expenses.items.remove(atOffsets: objectsToDelete)
        }
    }
    
    func removePersonalItems(at offsets: IndexSet) {
        var objectsToDelete = IndexSet()
        
        for offset in offsets {
            let item = expenses.personalItems[offset]
            
            if let index = expenses.items.firstIndex(of: item) {
                objectsToDelete.insert(index)
            }
            
            expenses.items.remove(atOffsets: objectsToDelete)
        }
    }
}

#Preview {
    ContentView()
}
