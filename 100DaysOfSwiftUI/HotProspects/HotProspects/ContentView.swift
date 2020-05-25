//
//  ContentView.swift
//  HotProspects
//
//  Created by Bruce on 2020/5/25.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI
import SamplePackage

struct ContentView: View {
  
  var body: some View {
    var prospects = Prospects()
    
    return TabView {
      ProspectsView(filter: .none)
        .tabItem {
          Image(systemName: "person.3")
          Text("Everyone")
      }
      ProspectsView(filter: .contacted)
        .tabItem {
          Image(systemName: "checkmark.circle")
          Text("Contacted")
      }
      ProspectsView(filter: .uncontacted)
        .tabItem {
          Image(systemName: "questionmark.diamond")
          Text("Uncontacted")
      }
      MeView()
        .tabItem {
          Image(systemName: "person.crop.square")
          Text("Me")
      }
    }
    .environmentObject(prospects)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
