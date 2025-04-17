//
//  AddView.swift
//  iExpense
//
//  Created by Bon Champion on 7/12/24.
//

import SwiftData
import SwiftUI

struct AddView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = "New expense"
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    @Query var expenses: [Expense]
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        Form {
//                 TextField("Name", text: $name) removed in favor of binded nav title
            
            Picker("Type", selection: $type) {
                ForEach(Self.types, id: \.self) {
                    Text($0)
                }
            }
            
            TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .keyboardType(.decimalPad)
        }
        .navigationTitle($name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    let item = Expense(name: name, type: type, amount: amount)
                    modelContext.insert(item)
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

#Preview {
    AddView()
        .modelContainer(for: Expense.self)
}
