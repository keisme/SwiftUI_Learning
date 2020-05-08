//
//  ContentView.swift
//  CustomBinding
//
//  Created by Bruce on 2020/5/8.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var agreeToFirst = false
  @State private var agreeToSecond = false
  @State private var agreeToThird = false
  
  var body: some View {
    let agreeToAll = Binding(get: {
      self.agreeToFirst && self.agreeToSecond && self.agreeToThird
    }) {
      self.agreeToFirst = $0
      self.agreeToSecond = $0
      self.agreeToThird = $0
    }
    
    return VStack {
      Toggle(isOn: $agreeToFirst) {
        Text("Agree to First")
      }
      
      Toggle(isOn: $agreeToSecond) {
        Text("Agree to Second")
      }
      
      Toggle(isOn: $agreeToThird) {
        Text("Agree to Third")
      }
      
      Toggle(isOn: agreeToAll) {
        Text("Agree to All")
      }
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
