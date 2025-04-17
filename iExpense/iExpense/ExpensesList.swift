//
//  ExpensesList.swift
//  iExpense
//
//  Created by Bon Champion on 1/24/25.
//

import SwiftData
import SwiftUI

struct ExpensesList: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    
    var body: some View {
        List {
            ForEach(expenses) { expense in
                HStack {
                    VStack(alignment: .leading) {
                        Text(expense.name)
                            .font(.headline)
                        Text(expense.type)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(expense.amount > 100 ? .red : .black)
                        .fontWeight(expense.amount > 100 ? .bold : .regular)
                        .italic(expense.amount < 10 ? true : false)
                }
                .accessibilityElement()
                .accessibilityLabel("\(expense.name): \(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                .accessibilityHint("\(expense.type) expense")
            }
            .onDelete(perform: removeItems)
        }
    }
    
    init(type: String, sortOrder: [SortDescriptor<Expense>]) {
        _expenses = Query(filter: #Predicate<Expense> {
            if type == "All" {
                return true
            } else {
                return $0.type == type
            }
        }, sort: sortOrder)
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let item = expenses[offset]
            modelContext.delete(item)
        }
    }
}

#Preview {
    ExpensesList(type: "All", sortOrder: [SortDescriptor(\Expense.name)])
        .modelContainer(for: Expense.self)
}
