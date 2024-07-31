//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Bon Champion on 6/12/24.
//

import SwiftUI

struct FlagImage: View {
    var url: String
    
    var body: some View {
        Image(url)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var correct = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var score = 0
    
    @State private var questionNumber = 0
    @State private var summaryTitle = ""
    @State private var summaryMessage = ""
    @State private var showingSummary = false
    
    @State private var tappedFlag = -1
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: (showingScore && !correct ? .red : Color(red: 0.46, green: 0.74, blue: 0.83)), location: 0.3),
                .init(color: Color(red: 0.9, green: 0.9, blue: 0.69), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 1000)
                .ignoresSafeArea()
                .animation(.easeInOut.speed(0.7), value: showingScore)
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.primary)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(url: countries[number])
                        }
                        .rotation3DEffect(.degrees(tappedFlag == number ? 360 : 0), axis: (x: 1, y: 0, z: 0))
                        .opacity(tappedFlag == -1 || tappedFlag == number ? 1.0 : 0.25)
                        .scaleEffect(tappedFlag == -1 || tappedFlag == number ? 1.0 : 0.9)
                        .animation(.default, value: tappedFlag)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 20)
                .padding(.bottom, 30)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundStyle(.secondary)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreMessage)
        }
        .alert(summaryTitle, isPresented: $showingSummary) {
            Button("Start over", action: startOver)
        } message: {
            Text(summaryMessage)
        }
    }
    
    func flagTapped(_ number: Int) {
        tappedFlag = number
        
        questionNumber += 1
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            scoreMessage = "Your score is \(score)"
            correct = true
        } else {
            scoreTitle = "Wrong!"
            scoreMessage = "That's the flag of \(countries[number])"
            correct = false
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        tappedFlag = -1
        
        if questionNumber >= 8 {
            summaryTitle = "You got \(score) \(score == 1 ? "point" : "points" )"
            switch score {
            case 8:
                summaryMessage = "Perfect! You know your flags!"
            case 5...7:
                summaryMessage = "Pretty good!"
            case 1...4:
                summaryMessage = "You need some more practice."
            case 0:
                summaryMessage = "Woof. Read a dang book."
            default:
                summaryMessage = "How did you get this score?"
            }
            
            showingSummary = true
        }
    }
    
    func startOver() {
        questionNumber = 0
        score = 0
    }
}

#Preview {
    ContentView()
}
