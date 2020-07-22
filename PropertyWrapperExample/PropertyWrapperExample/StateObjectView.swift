//
//  StateObjectView.swift
//  PropertyWrapperExample
//
//  Created by Bruce on 2020/7/22.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

class Counter: ObservableObject {
  @Published var count: Int = 0
}


struct StateObjectView: View {
  
  @State private var buttonTitle = "Tap me"
  
  var body: some View {
    VStack {
      Group {
        Button(buttonTitle) {
          buttonTitle = buttonTitle == "Tap me" ? "Tapped" : "Tap me"
        }
        CounterView1()
        CounterView2()
      }
      .padding()
    }
  }
}


struct ItemList: View {
  @State private var items = ["hello", "world"]
  
  var body: some View {
    VStack {
      Button("Append item to list") {
        items.append("test")
      }
      
      List(items, id: \.self) { name in
        Text(name)
      }
      
      CounterView1()
      
      CounterView2()
    }
  }
}

struct CounterView1: View {
  @StateObject var counter1 = Counter()
  var body: some View {
    VStack {
      Text("StateObject count: \(counter1.count)")
      Button("IncrementStateObject") {
        counter1.count += 1
      }
    }
  }
}

struct CounterView2: View {
  @ObservedObject var counter2 = Counter()
  var body: some View {
    VStack {
      Text("ObservedObject count: \(counter2.count)")
      Button("IncrementObservedObject") {
        counter2.count += 1
      }
    }
  }
}
