//
//  ContentView.swift
//  Word Scramble
//
//  Created by Bon Champion on 7/1/24.
//

import SwiftUI

struct ContentView: View {
    enum FocusedField {
        case answer
    }
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var score: Int = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var useSBRules = false
    
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .focused($focusedField, equals: .answer)
                        .textInputAutocapitalization(.never)
                        .onAppear {
                            focusedField = .answer
                        }
                    Toggle(isOn: $useSBRules) {
                        Text("Use Spelling Bee rules")
                    }
                } footer: {
                    if useSBRules {
                        Text("Rules: words must be 4 letters or more, and 4 letter words are only worth 1 point. Also, letters can be reused.")
                    } else {
                        Text("Rules: words must be 3 letters or more, and every word is worth its length in points. Letters cannot be reused.")
                    }
                }
                
                HStack {
                    Text("Your score")
                    Spacer()
                    Text("\(score)")
                        .fontWeight(.bold)
                }
                .accessibilityElement(children: .combine)
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        .accessibilityElement()
                        .accessibilityLabel("\(word), \(word.count) letters")
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) { } message : {
                Text(errorMessage)
            }
            .toolbar {
                Button("New word") {
                    startGame()
                }
            }
            .preferredColorScheme(.dark)
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isLongEnough(word: answer) else {
            wordError(title: "Not long enough", message: "Must be at least \( useSBRules ? "4" : "3") letters.")
            return
        }
        
        guard isNotRoot(word: answer) else {
            wordError(title: "That's just the root word", message: "Be more original!")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Impossible!", message: "You can't spell that with '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make 'em up!")
            return
        }
        
        withAnimation {
            if useSBRules {
                if answer.count == 4 {
                    score += 1
                } else {
                    score += answer.count
                }
            } else {
                score += answer.count
            }
            
            usedWords.insert(answer, at: 0)
            newWord = ""
        }
        
        focusedField = .answer
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                
                usedWords = [String]()
                score = 0
                
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isLongEnough(word: String) -> Bool {
        if useSBRules {
            word.count >= 4
        } else {
            word.count >= 3
        }
    }
    
    func isNotRoot(word: String) -> Bool {
        word != rootWord
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                if !useSBRules {
                    tempWord.remove(at: pos)
                }
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

#Preview {
    ContentView()
}
