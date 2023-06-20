//
//  ContentView.swift
//  Project1_WeSplit
//
//  Created by Ning, Xinran on 12/6/23.
//

import SwiftUI

struct ContentView: View {

  @State private var checkAmount = 0.0
  @State private var numOfPeople = 0
  @State private var tipPercentage = 20

  let myCurrency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")

  var peopleCount: Double {
    return Double(numOfPeople + 2)
  }

  var grandTotal: Double {
    let tipSelection = Double(tipPercentage)
    let tipValue = checkAmount / 100 * tipSelection

    return checkAmount + tipValue
  }

  // computed property
  var totalPerPerson: Double {
    let amountPerPerson = grandTotal / peopleCount

    return amountPerPerson
  }

  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Amount", value: $checkAmount, format: myCurrency)
            .keyboardType(.decimalPad)

          Picker("Number of people", selection: $numOfPeople) {
            ForEach(2..<100) {
              Text("\($0) people")
            }
          }
        }

        Section {
          Picker("Tip percentage", selection: $tipPercentage) {
            ForEach(0..<101) {
              Text($0, format: .percent)
            }
          }
          .pickerStyle(.segmented)
        } header: {
          Text("Tip percentage: \(tipPercentage)%")
        }

        Section{
          Text(grandTotal, format: myCurrency)
        } header: {
          Text("Grand total:")
        }

        Section {
          Text(totalPerPerson, format: myCurrency)
        } header: {
          Text("Amount per person:")
        }
      }
      .navigationTitle("WeSplit")
    }
  }

}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
