//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Bon Champion on 7/10/24.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expense.self)
    }
}
