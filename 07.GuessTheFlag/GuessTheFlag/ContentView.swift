//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Battal Uçar on 1.04.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingResult = false
    
    @State private var resultTitle = ""
    @State private var scoreTitle = ""
    
    @State private var message = ""
    @State private var resultMessage = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    
    @State private var questionAmount = 8
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.teal, .purple], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
//            RadialGradient(stops: [
//                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
//                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
//            ], center: .top, startRadius: 200, endRadius: 550)
//            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .foregroundColor(.black)
                    .font(.largeTitle.weight(.bold))
                VStack(spacing: 15) {
                    VStack(alignment: .center) {
                        HStack {
                            VStack(alignment: .center) {
                                Text("Tap the flag of")
                                    .foregroundColor(.secondary)
                                    .font(.subheadline.weight(.heavy))
                                Text(countries[correctAnswer])
                                    .font(.largeTitle.weight(.semibold))
                                    .shadow(radius: 2)
                            }
                            .frame(width: 250)
                            .padding(EdgeInsets(top: 0, leading: 45, bottom: 0, trailing: 0))
                            VStack(alignment: .trailing) {
                                Text("\(questionAmount)")
                                    .padding(15)
                                    .background(.ultraThinMaterial  )
                                    .clipShape(Circle())
                                    .font(.body.weight(.bold))
                            }
                            .frame(alignment: .trailing)
                        }
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 15)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                
                Spacer()
                Spacer()
                
                VStack {
                    Text("Score: \(score)")
                }
                .foregroundColor(.white)
                .font(.title.weight(.bold))
                .padding(10)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                Spacer()
            }
            .padding()
            Spacer()
        }
        .alert(isPresented: $showingScore) {
            if questionAmount > 0 {
                return Alert(title: Text(scoreTitle), message: Text(message), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
            }
            else {
                return Alert(title: Text(resultTitle),
                             message: Text(resultMessage),
                             primaryButton: .default(Text("Continue")) {
                    questionAmount = 9
                    self.askQuestion()
                },
                             secondaryButton: .destructive(Text("Reset")) {
                    self.askQuestion()
                    self.showResult()
                })
            }
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer {
            scoreTitle = "Correct!"
            message = ""
            score += 1
        }
        else {
            scoreTitle = "Wrong!"
            score -= 1
            message = "That's the flag of \(countries[number])"
        }
        showingScore = true
        
        if questionAmount == 0 {
            switch score {
            case -10...0:
                resultTitle = "Very Bad"
                resultMessage = "Score: \(score)\nYou should work more on flags."
            case 0..<3:
                resultTitle = "Rookie"
                resultMessage = "Score: \(score)\nYou are a beginner."
            case 3..<6:
                resultTitle = "Good"
                resultMessage = "Score: \(score)\nYou're making progress."
            case 6...9:
                resultTitle = "Expert"
                resultMessage = "Score: \(score)\nYou mastered the flags."
            default:
                resultTitle = "Results"
                resultMessage = "Score: \(score)"
            }
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionAmount -= 1
    }
    
    func showResult() {
        questionAmount = 8
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
