//
//  ContentView.swift
//  Project2_GuessTheFlag
//
//  Created by Ning, Xinran on 19/6/23.
//

import SwiftUI

struct ContentView: View {
  @State private var showingScore = false
  @State private var showingReset = false
  @State private var scoreTitle = ""
  @State private var score = 0
  @State private var numQuestionsAsked = 1

  @State private var countries = ["estonia", "france", "germany", "ireland", "italy", "nigeria", "poland", "russia", "spain", "uk", "us"].shuffled()
  @State private var correctAnswer = Int.random(in: 0...2)

  private let questionsPerGame = 8

    var body: some View {
      ZStack {
        let gradient = Gradient(colors: [.blue, .gray])
        LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
          .ignoresSafeArea()

        VStack(spacing: 30) {
          VStack {
            Text("Tap the flag of")
              .foregroundColor(.white)
              .font(.subheadline.weight(.heavy))
            Text(countries[correctAnswer].uppercased())
              .foregroundColor(.white)
              .font(.largeTitle.weight(.semibold))
          }

          Spacer()

          ForEach(0..<3) { number in
            Button {
              flagTapped(number)
            }
            label: {
              Image(countries[number])
                .renderingMode(.original)
                .clipShape(Capsule())
                .shadow(radius: 5)
            }
          }

          Spacer()

          Text("Score: \(score)")
            .foregroundColor(.white)
        }

      }
      .alert(scoreTitle, isPresented: $showingScore) {
        Button("Continue", action: askQuestionOrReset)
      } message: {
        Text("Your score is \(score)")
      }
      .alert("Good job!", isPresented: $showingReset) {
        Button("Play again", action: reset)
      } message: {
        Text("You've scored \(score) out of \(questionsPerGame).")
      }
    }

  func flagTapped(_ number: Int) {
    if number == correctAnswer {
      scoreTitle = "Correct"
      score += 1
    }
    else {
      let chosenCountry = countries[number].uppercased()
      scoreTitle = "Wrong, that's the flag of \(chosenCountry)"
      score = max(score - 1, 0)
    }

    showingScore = true
  }

  func askQuestionOrReset() {
    if (numQuestionsAsked >= questionsPerGame) {
      showingReset = true
    }
    else {
      askQuestion()
    }
  }

  func askQuestion() {
    // reshuffles array and pick new correctAnswer
    numQuestionsAsked += 1
    countries.shuffle()
    correctAnswer = Int.random(in: 0..<3)
  }

  func reset() {
    numQuestionsAsked = 0
    score = 0
    askQuestion()
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
