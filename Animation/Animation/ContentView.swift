//
//  ContentView.swift
//  Animation
//
//  Created by Bruce on 2020/6/29.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      List {
        NavigationLink("Repeat", destination: Repeat())
      }
      .navigationBarTitle("Animation")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
