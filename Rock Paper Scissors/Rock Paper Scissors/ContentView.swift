//
//  ContentView.swift
//  Rock Paper Scissors
//
//  Created by Bon Champion on 6/21/24.
//


import SwiftUI

struct ContentView: View {
    
    let answers = ["Rock", "Paper", "Scissors"]

    @State private var gamesOption = Int.random(in:0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var questionNumber = 0
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    
    @State private var showingSummary = false
    @State private var summaryTitle = ""
    @State private var summaryMessage = ""

    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            Spacer()
            Text("I choose")
                .foregroundStyle(.secondary)
            Text(answers[gamesOption])
                .font(.largeTitle.bold())
            Spacer()
            Text("and I want you to")
                .foregroundStyle(.secondary)
            Text(shouldWin ? "Win" : "Lose")
                .font(.largeTitle.bold())
            Spacer()
            Spacer()
            
            HStack {
                Spacer()
                Button {
                    attempt(answer: 0)
                    
                } label: {
                    Text("🪨")
                        .foregroundColor(.black)
                        .font(.system(size: 70))
                }
                Spacer()
                Button {
                    attempt(answer: 1)
                    
                } label: {
                    Text("🗒")
                        .foregroundColor(.black)
                        .font(.system(size: 70))
                }
                Spacer()
                Button {
                    attempt(answer: 2)
                    
                } label: {
                    Text("✂️")
                        .foregroundColor(.black)
                        .font(.system(size: 60))
                }
                Spacer()
            }
            Spacer()
            Spacer()
            Text("Score: \(score)")
                .foregroundStyle(.secondary)
            Spacer()
        }
        .padding()
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: shoot)
        } message: {
            Text(scoreMessage)
        }
        .alert(summaryTitle, isPresented: $showingSummary) {
            Button("Start over", action: reset)
        } message: {
            Text(summaryMessage)
        }
    }
    
    func attempt(answer: Int) {
        var winningOption: Int
        if shouldWin {
            winningOption = gamesOption == 2 ? 0 : gamesOption + 1
        } else {
            winningOption = gamesOption == 0 ? 2 : gamesOption - 1
        }
        
        if answer == winningOption {
            score += 1
            scoreTitle = "Nice!"
            scoreMessage = "Now do it \(9 - questionNumber) more times."
            showingScore = true
        } else {
            scoreTitle = "Whoops!"
            scoreMessage = "Wrong, but you've got \(9 - questionNumber) more tries."
            showingScore = true
        }
    }
    
    func shoot(){
        questionNumber += 1
        
        if questionNumber >= 10 {
            summaryTitle = "You got \(score) \(score == 1 ? "point" : "points" )"
            switch score {
            case 10:
                summaryMessage = "Perfect!"
            case 5...9:
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
        
        gamesOption = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
    
    func reset() {
        questionNumber = 0
        score = 0
    }
}

#Preview {
    ContentView()
}
