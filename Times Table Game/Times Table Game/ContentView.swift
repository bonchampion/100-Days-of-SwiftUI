//
//  ContentView.swift
//  Times Table Game
//
//  Created by Bon Champion on 7/9/24.
//

import SwiftUI

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

struct ContentView: View {
    
    enum FocusedField {
        case answer
    }
    
    @State private var chosenTable: Int = 2
    @State private var chosenDifficulty: String = "Medium"
    @State private var totalQuestions: Int = 10
    @State private var difficulties = ["Easy","Medium","Hard"]
    
    @State private var started: Bool = false
    
    @State private var score: Int = 0
    @State private var questionOptions = [Int]()
    @State private var currentQuestion: Int = 0
    
    @State private var userAnswer: String = ""
    
    @State private var backgroundColor = UIColor.systemGroupedBackground
    @State private var animationAmount = 0.0
    @State private var progressOffset = -(UIScreen.screenWidth)
    
    @State private var showingSummary = false
    @State private var summaryMessage = ""
    
    @FocusState private var focusedField: FocusedField?
    
    var settingsView: some View {
        VStack {
            Form {
                Section("Choose your times table"){
                    Stepper("Multiples of \(chosenTable)", value: $chosenTable, in: 2...12)
                }
                Section{
                    Picker("Difficulty", selection: $chosenDifficulty) {
                        ForEach(difficulties, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header : {
                    Text("Choose your difficulty")
                }
            footer: {
                Text("Easy gets 5 questions. Medium gets 10. At Hard you'll be multiplying up to 20!")
            }
            }
            .navigationTitle("The Math Game")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Start") {
                    withAnimation(.easeOut.speed(0.5)) {
                        started = true
                    }
                    startGame()
                }
            }
        }
    }
    
    var gameView: some View {
        ZStack {
            Color(backgroundColor)
                .ignoresSafeArea()
            
            Color(.gray)
                .ignoresSafeArea()
                .offset(CGSize(width: progressOffset, height: 0.0))
                .opacity(0.25)
            
            VStack {
                Spacer()
                
                Text("\(currentQuestion) x \(chosenTable)")
                    .font(.system(size: 80, design: .rounded))
                    .fontWeight(.bold)
                
                TextField("Answer", text: $userAnswer)
                    .focused($focusedField, equals: .answer)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                    .font(.system(size: 40))
                    .multilineTextAlignment(.center)
                    .onAppear {
                        focusedField = .answer
                    }
                    .onSubmit {
                        answer(userAnswer)
                    }
                
                Spacer()
                
                Text("Score: \(score)")
                    .frame(width: 150, height: 150)
                    .font(.system(.title, design: .rounded))
                    .background(.black.opacity(0.1))
                    .background(.regularMaterial)
                    .clipShape(Circle())
                    .rotation3DEffect(.degrees(animationAmount), axis: (x: 0.7, y: 0.3, z: 0.2)
                    )
            }
            .padding(20)
        }
    }
    
    
    var body: some View {
        NavigationStack {
            if !started {
                settingsView
            } else {
                gameView
            }
        }
        .alert("You got \(score) out of \(totalQuestions)", isPresented: $showingSummary) {
            Button("New game") {
                score = 0
                withAnimation(.easeOut.speed(0.5)) {
                    started = false
                }
            }
        } message: {
            Text(summaryMessage)
        }
        
    }
    
    func startGame() {
        questionOptions.removeAll()
        switch chosenDifficulty {
        case "Easy":
            totalQuestions = 5
        case "Medium":
            totalQuestions = 10
        case "Hard":
            totalQuestions = 20
        default:
            totalQuestions = 5
        }
        
        for i in 0..<totalQuestions {
            questionOptions.append(i + 1)
        }
        
        newQuestion()
    }
    
    func newQuestion() {
        let percentProgress: Double = Double(questionOptions.count) / Double(totalQuestions)
        
        withAnimation {
            progressOffset = -(UIScreen.screenWidth * CGFloat(percentProgress))
        }
        if !questionOptions.isEmpty {
            currentQuestion = questionOptions.randomElement() ?? 2
            if let index = questionOptions.firstIndex(of: currentQuestion) {
                questionOptions.remove(at: index)
            }
            
            userAnswer = ""
            focusedField = .answer
        } else {
            switch score {
            case 0..<2 :
                summaryMessage = "Practice your math!"
            case 2..<4 :
                summaryMessage = "You've got room to improve"
            case 4..<6 :
                summaryMessage = "Pretty good!"
            case 6..<10 :
                summaryMessage = "You know your math!"
            case 10..<15 :
                summaryMessage = "You're great at this!"
            case 15..<19 :
                summaryMessage = "You're a whiz!!!"
            case 20 :
                summaryMessage = "You have nothing left to learn."
            default :
                summaryMessage = "How did you get this score?"
            }
            
            showingSummary = true
        }
    }
    
    func answer(_ answerString: String) {
        let answer = Int(answerString)
        if answer == currentQuestion * chosenTable {
            score += 1
            withAnimation {
                backgroundColor = UIColor(red: 0.43, green: 0.82, blue: 0.49, alpha: 1)

                animationAmount += 360
            } completion: {
                withAnimation {
                    backgroundColor = UIColor.systemGroupedBackground
                }
            }
        } else {
            withAnimation {
                backgroundColor = UIColor(red: 0.91, green: 0.34, blue: 0.34, alpha: 1)
            } completion: {
                withAnimation {
                    backgroundColor = UIColor.systemGroupedBackground
                }
            }
        }
        
        newQuestion()
    }
}

#Preview {
    ContentView()
}
