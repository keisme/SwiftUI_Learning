//
//  LazyVStackView.swift
//  LazyStack&LazyGrid
//
//  Created by Bruce on 2020/7/22.
//

import SwiftUI

struct LazyVStackView: View {
  var body: some View {
    
    VStack(spacing: 20) {
      ScrollView {
        LazyVStack {
          ForEach(1...100, id: \.self) { count in
            Text("Placeholder \(count)")
          }
        }
      }
      
      Divider()
      
      ScrollView(showsIndicators: false) {
        LazyVStack(alignment: .center, spacing: 20, pinnedViews: [.sectionHeaders, .sectionFooters]) {
          Section(
            header: Text("Header")
              .frame(maxWidth: .infinity)
              .background(Color.white),
            footer: Text("Footer")
              .frame(maxWidth: .infinity)
              .background(Color.white)) {
            ForEach(1...100, id: \.self) { count in
              Text("Placeholder \(count)")
            }
          }
        }
      }
      .edgesIgnoringSafeArea(.all)
    }
  }
}

struct LazyVStackView_Previews: PreviewProvider {
  static var previews: some View {
    LazyVStackView()
  }
}
