//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Battal Uçar on 8.04.2022.
//

import SwiftUI

extension Image {
    
    func imageIconModifier() -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: 75, height: 75)
            .padding()
            .background(Color(red: 200 / 255, green: 200 / 255, blue: 200 / 255))
            .clipShape(Circle())
    }
}

struct ContentView: View {
    
    private let possibleMoves = ["Rock", "Paper", "Scissors"]
    
    @State private var resultMessage: String = ""
    @State public var machineChoice: String = "question-mark-2"
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 255 / 255, green: 94 / 255, blue: 247 / 255), Color(red: 2 / 255, green: 245 / 255, blue: 255 / 255)], startPoint: .top, endPoint: .bottom)
            // rgba(255,94,247,1) 17.8%, rgba(2,245,255,1
                            .ignoresSafeArea()
            VStack {
                VStack {
                    Spacer(minLength: 80)
                    Text("Rock,\tPaper,\tScissors?")
                        .font(.title)
                        .foregroundColor(Color(red: 255 / 255, green: 255 / 255, blue: 150 / 255))
                    Spacer(minLength: 90)
                    HStack(spacing: 15) {
                        ForEach(0..<3) { number in
                            Button {
                                emojiTapped(number)
                            } label: {
                                Image(possibleMoves[number])
                                    .imageIconModifier()
                            }
                        }
                    }
                    Spacer(minLength: 100)
                    Text("Machine's Choice")
                        .underline()
                        .foregroundColor(Color(red: 255, green: 215, blue: 0))
                    Image(machineChoice)
                        .imageIconModifier()
                    Spacer()
                    Spacer()
                }
                Text(resultMessage)
                    .font(.title)
                Spacer(minLength: 70)
            }
        }
    }
    func emojiTapped(_ number: Int) {
        machineChoice = possibleMoves.randomElement()!
        switch machineChoice {
        case "Rock":
            switch number {
            case 0:
                resultMessage = "Tie"
            case 1:
                resultMessage = "Win"
            case 2:
                resultMessage = "Lose"
            default:
                resultMessage = ""
            }
        case "Paper":
            switch number {
            case 0:
                resultMessage = "Lose"
            case 1:
                resultMessage = "Tie"
            case 2:
                resultMessage = "Win"
            default:
                resultMessage = ""
            }
        case "Scissors":
            switch number {
            case 0:
                resultMessage = "Win"
            case 1:
                resultMessage = "Lose"
            case 2:
                resultMessage = "Tie"
            default:
                resultMessage = ""
            }
        default:
            resultMessage = ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
