//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by James Chun on 7/28/21.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2, x: 4, y: 4)
                    }
                }
                Spacer()
            }
        }
        .alert(isPresented: $showingScore, content: {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                if scoreTitle == "Correct Answer" {
                    self.askQuestion()
                }
            })
        })
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct Answer"
        } else {
            scoreTitle = "Wrong"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
    
}//End of struct

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}//End of struct
