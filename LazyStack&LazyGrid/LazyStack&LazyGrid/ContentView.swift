//
//  ContentView.swift
//  LazyStack&LazyGrid
//
//  Created by Bruce on 2020/7/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      NavigationView {
        List {
          NavigationLink(destination: LazyHStackView(), label: { Text("LazyHStackView") })
          NavigationLink(destination: LazyVStackView(), label: { Text("LazyVStackView") })
          NavigationLink(destination: LazyHGridView(), label: { Text("LazyHGridView") })
          NavigationLink(destination: LazyVGridView(), label: { Text("LazyVGridView") })
        }
        .navigationBarTitle("LazyStack&LazyGrid", displayMode: .inline)
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
