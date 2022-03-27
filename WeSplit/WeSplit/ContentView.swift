//
//  ContentView.swift
//  WeSplit
//
//  Created by Battal Uçar on 27.03.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double = 0.0
    @State private var numberOfPeople: Int = 2
    @State private var tipPercentage: Int = 20
    @FocusState private var amountIsFocused: Bool
    
    let currencyCode: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    
    let tipPercentages: [Int] = [0, 10, 15, 20, 25]
    
    
    public var totalAmount: (Double, Double) {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return (amountPerPerson, grandTotal)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyCode)
                    Picker("Number of people:", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                } header: {
                    Text("ENTER THE CHECK AMOUNT")
                }
                .keyboardType(.decimalPad)
                .focused($amountIsFocused)
                
                Section {
                    Picker("Tip Percentages", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("TIP PERCENTAGE")
                }
                
                Section {
                    Text(totalAmount.1, format: currencyCode)
                } header: {
                    Text("TOTAL AMOUNT")
                }
                
                Section {
                    Text(totalAmount.0, format: currencyCode)
                } header: {
                    Text("AMOUNT PER PERSON")
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
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
