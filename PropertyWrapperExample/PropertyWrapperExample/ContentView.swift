//
//  ContentView.swift
//  PropertyWrapperExample
//
//  Created by Bruce on 2020/5/20.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  private let ds = [
    "@State、@Binding",
    "@ObservedObject、@Published、ObservableObject",
    "Environment"
  ]
  
  var body: some View {
    
    NavigationView {
      Form {
        NavigationLink("@State、@Binding", destination: StateView())
        NavigationLink("@ObservedObject、@Published、ObservableObject", destination: ObservedObjectView())
        NavigationLink("@Environment、EnvironmentValues", destination: EnvironmentView())
        NavigationLink("@EnvironmentObjectView", destination: EnvironmentObjectView())
      }
      .navigationBarTitle("Example", displayMode: .automatic)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
