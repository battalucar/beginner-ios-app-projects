//
//  ContentView.swift
//  TimeConversions
//
//  Created by Battal Uçar on 27.03.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var from: fromTimeIntervals = .secs
    @State private var to: toTimeIntervals = .mins
    @State private var fromVal: Int = 1
    @State private var toVal: Int = 1
    @FocusState private var isInputFocused: Bool
    
    enum fromTimeIntervals: String, CaseIterable, Identifiable {
        case secs, mins, hours, days
        var id: Self { self }
    }
    
    enum toTimeIntervals: String, CaseIterable, Identifiable {
        case secs, mins, hours, days
        var id: Self { self }
    }
    
    public var convertedValue: Double {
        let fromValue = Double(fromVal)
        var toValue = Double(toVal)
        switch (from) {
        case fromTimeIntervals.secs:
            switch (to) {
            case toTimeIntervals.secs:
                return fromValue
            case toTimeIntervals.mins:
                toValue = fromValue / 60
                return toValue
            case toTimeIntervals.hours:
                toValue = fromValue / 3600
            case toTimeIntervals.days:
                toValue = fromValue / 86400
            }
        case fromTimeIntervals.mins:
            switch (to) {
            case toTimeIntervals.secs:
                toValue = fromValue * 60
            case toTimeIntervals.mins:
                return fromValue
            case toTimeIntervals.hours:
                toValue = fromValue / 60
            case toTimeIntervals.days:
                toValue = fromValue / 1440
            }
        case fromTimeIntervals.hours:
            switch (to) {
            case toTimeIntervals.secs:
                toValue = fromValue * 3600
            case toTimeIntervals.mins:
                toValue = fromValue * 60
            case toTimeIntervals.hours:
                return fromValue
            case toTimeIntervals.days:
                toValue = fromValue / 24
                
            }
        case fromTimeIntervals.days:
            switch (to) {
            case toTimeIntervals.secs:
                toValue = fromValue * 86400
            case toTimeIntervals.mins:
                toValue = fromValue * 360
            case toTimeIntervals.hours:
                toValue = fromValue * 24
            case toTimeIntervals.days:
                return fromValue
                
            }
        }
        return toValue
    }
        
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("From", selection: $from) {
                        ForEach(fromTimeIntervals.allCases) {
                            Text($0.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("From")
                }
                
                Section {
                    Picker("To", selection: $to) {
                        ForEach(toTimeIntervals.allCases) {
                            Text($0.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("To")
                }
                
                Section {
                    TextField("From Value:", value: $fromVal, format: .number)
                } header: {
                    Text("Input")
                }
                .focused($isInputFocused)
                .keyboardType(.decimalPad)
                
                Section {
                    Text("\(convertedValue.formatted())")
                } header: {
                    Text("Output")
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isInputFocused = false
                    }
                }
            }
        }
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
