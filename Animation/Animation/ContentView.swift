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
        Section(header: Text("Type")) {
          NavigationLink("Repeat", destination: Repeat())
          NavigationLink("Rotation3DEffect", destination: Rotation3DEffect())
          NavigationLink("PathAnimation", destination: PathAnimation())
          NavigationLink("CustomTransition", destination: CustomTransition())
          NavigationLink("MatchedGeometryEffect", destination: MatchedGeometryEffect())
        }
        
        Section(header: Text("Example")) {
          NavigationLink("Checkbox", destination: Checkbox())
        }
      }
      .listStyle(InsetGroupedListStyle())
      .navigationBarTitle("Animation")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
