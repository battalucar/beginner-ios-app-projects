//
//  ContentView.swift
//  BetterRest
//
//  Created by Battal Uçar on 13.04.2022.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeIntake = 1
    @State private var finalTitle = ""
    @State private var finalMessage = ""
    @State private var sleepTime = 2
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("When do you want to wake up?")
                            .font(.headline)
                    DatePicker("Time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                }
                
                Section {
                    Text("Desired amount of sleep")
                            .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                Section {
                    Text("Daily coffee intake")
                            .font(.headline)
//                    Stepper(coffeeIntake == 1 ? "1 cup": "\(coffeeIntake) cups", value: $coffeeIntake, in: 1...20)
                    Picker("Daily Coffee Intake", selection: $coffeeIntake) {
                        ForEach(1...20, id: \.self) {
                            if $0 == 1 {
                                Text("\($0) cup")
                            }
                            else {
                                Text("\($0) cups")
                            }
                        }
                    }
                }
                
                Section {
                    VStack {
                        Text("l")
                        Text("l")
                    }
                }
            }
        .navigationTitle("BetterRest")
        }
    }
    
    func calculateBedTime() -> (String, String) {
        var calculatedTitle = ""
        var calculatedMessage = ""
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60 // number of hours in seconds
            let minute = (components.minute ?? 0) * 60 // number of minutes in seconds

            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeIntake))

            let bedTime = wakeUp - prediction.actualSleep

            calculatedTitle = "Your ideal bed time is..."
            calculatedMessage = bedTime.formatted(date: .omitted, time: .shortened)
        }
        catch {
            calculatedTitle = "Error"
            calculatedMessage = "Sorry, there was a problem calculating your bedtime."
        }
        
        return (calculatedTitle, calculatedMessage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
