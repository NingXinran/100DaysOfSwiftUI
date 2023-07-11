//
//  ContentView.swift
//  Project2_GuessTheFlag
//
//  Created by Ning, Xinran on 19/6/23.
//

import SwiftUI

struct ContentView: View {
  @State private var showingScore = false
  @State private var scoreTitle = ""

  @State private var countries = ["estonia", "france", "germany", "ireland", "italy", "nigeria", "poland", "russia", "spain", "uk", "us"].shuffled()
  @State private var correctAnswer = Int.random(in: 0...2)

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
        }
      }
      .alert(scoreTitle, isPresented: $showingScore) {
        Button("Continue", action: askQuestion)
      } message: {
        Text("Your score is ???")
      }
    }

  func flagTapped(_ number: Int) {
    if number == correctAnswer {
      scoreTitle = "Correct"
    }
    else {
      scoreTitle = "Wrong"
    }

    showingScore = true
  }

  func askQuestion() {
    // reshuffles array and pick new correctAnswer
    countries.shuffle()
    correctAnswer = Int.random(in: 0..<3)
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
