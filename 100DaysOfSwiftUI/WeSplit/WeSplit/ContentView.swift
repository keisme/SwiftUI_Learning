//
//  ContentView.swift
//  WeSplit
//
//  Created by Bruce on 2020/5/7.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var tapCount = 0
  @State private var name = ""
  @State private var selectedStudent = 0
  @State private var checkAmount = ""
  @State private var numberOfPeople = 2
  @State private var tipPercentage = 2
  private let students = ["Harry", "Hermione", "Ron"]
  private let tipPercentages = [10, 15, 20, 25, 0]
  private var totalPerPerson: Double {
    let peopleCount = Double(numberOfPeople + 2)
    let tipSelection = Double(tipPercentages[tipPercentage])
    let orderAmount = Double(checkAmount) ?? 0
    let tipValue = orderAmount / 100 * tipSelection
    let grandTotal = orderAmount + tipValue
    let amountPerPersont = grandTotal / peopleCount
    return amountPerPersont
  }
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          Text("Hello, World!")
        }
        
        Picker("Select your student", selection: $selectedStudent) {
          ForEach(0..<students.count) {
            Text(self.students[$0])
          }
        }
        Text("You chose: Student # \(students[selectedStudent])")
        
        Section {
          Button("Tap Count: \(tapCount)") {
            self.tapCount += 1
          }
        }
        
        Section {
          TextField("Enter you name", text: $name)
          Text("Your name is \(name)")
        }
        
        Section(header: Text("Amout per person")) {
          TextField("Amount", text: $checkAmount)
            .keyboardType(.decimalPad)
          Text("$\(totalPerPerson, specifier: "%.2f")")
          Picker("Number of people", selection: $numberOfPeople) {
            ForEach(2..<100) {
              Text("\($0) people")
            }
          }
        }
        
        Section(header: Text("How much tip do you want to leave?")) {
          Picker("Tip percentage", selection: $tipPercentage) {
            ForEach(0 ..< tipPercentages.count) {
              Text("\(self.tipPercentages[$0])%")
            }
          }
          .pickerStyle(SegmentedPickerStyle())
        }
      }
      .navigationBarTitle("WeSplit")
    }
  }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ContentView()
        .previewDevice("iPhone XS")
        .previewDisplayName("iPhone XS")
      
      ContentView()
        .previewDevice("iPhone SE")
        .previewDisplayName("iPhone SE")
    }
  }
}
#endif
