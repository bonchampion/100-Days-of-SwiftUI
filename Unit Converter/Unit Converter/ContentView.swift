//
//  ContentView.swift
//  Unit Converter
//
//  Created by Bon Champion on 6/10/24.
//

import SwiftUI
import Foundation

struct ContentView: View {
    enum TimeUnit: String, CaseIterable, Identifiable {
        case seconds, minutes, hours, days, weeks, months, years
        var id: Self { self }
    }
    
    @State private var inputUnit: TimeUnit = .seconds
    @State private var outputUnit: TimeUnit = .hours
    @State private var value: Double = 0
    @FocusState private var valueisFocused: Bool
    
    private var inputInSeconds: Double {
        switch inputUnit {
        case .seconds:
            return value
        case .minutes:
            return value * 60
        case .hours:
            return value * 60 * 60
        case .days:
            return value * 60 * 60 * 24
        case .weeks:
            return value * 60 * 60 * 24 * 7
        case .months:
            return value * 60 * 60 * 24 * 30
        case .years:
            return value * 60 * 60 * 24 * 365
        }
    }
    
    private var output: Double {
        switch outputUnit {
        case .seconds:
            return inputInSeconds
        case .minutes:
            return inputInSeconds / 60
        case .hours:
            return inputInSeconds / 60 / 60
        case .days:
            return inputInSeconds / 60 / 60 / 24
        case .weeks:
            return inputInSeconds / 60 / 60 / 24 / 7
        case .months:
            return inputInSeconds / 60 / 60 / 24 / 30
        case .years:
            return inputInSeconds / 60 / 60 / 24 / 365
        }
    }
    
   
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(TimeUnit.allCases) { unit in
                            Text("\(unit.rawValue)")
                        }
                    }
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(TimeUnit.allCases) { unit in
                            Text("\(unit.rawValue)")
                        }
                    }
                }
                Section {
                    TextField("Value", value: $value, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($valueisFocused)
                }
                Section("Converted time") {
                    Text("\(output.formatted()) \(outputUnit.rawValue)")
                }
            }
            .navigationTitle("Time Converter")
            .toolbar {
                if valueisFocused {
                    Button("Done") {
                        valueisFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
