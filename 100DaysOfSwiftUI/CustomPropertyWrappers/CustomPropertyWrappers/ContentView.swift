//
//  ContentView.swift
//  CustomPropertyWrappers
//
//  Created by Bruce on 2020/5/19.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

@propertyWrapper
struct NonNegative<Value: BinaryInteger> {
  var value: Value
  
  init(wrappedValue: Value) {
    if wrappedValue < 0 {
      self.value = 0
    } else {
      self.value = wrappedValue
    }
  }
  
  var wrappedValue: Value {
    get { value }
    set {
      if newValue < 0 {
        value = 0
      } else {
        value = newValue
      }
    }
  }
}

struct User {
  @NonNegative var score = 0
}

struct ContentView: View {
    var body: some View {
        Text("\(getScore())")
    }
  
  func getScore() -> Int {
    var user = User()
    user.score += 10
    user.score -= 20
    print(user.score)
    return user.score
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
