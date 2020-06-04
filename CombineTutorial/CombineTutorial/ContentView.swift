//
//  ContentView.swift
//  CombineTutorial
//
//  Created by Bruce on 2020/6/3.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI
import Combine

var subscriptions = Set<AnyCancellable>()

struct ContentView: View {
    var body: some View {
      NavigationView {
        List {
          NavigationLink("Convenience Publishers", destination: PublisherView())
        }
        .navigationBarTitle("CombineTutorial", displayMode: .inline)
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
