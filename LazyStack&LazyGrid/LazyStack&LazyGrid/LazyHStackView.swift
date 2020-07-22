//
//  LazyHStackView.swift
//  LazyStack&LazyGrid
//
//  Created by Bruce on 2020/7/22.
//

import SwiftUI

struct LazyHStackView: View {
  var body: some View {
    VStack(spacing: 20) {
      ScrollView(.horizontal) {
        LazyHStack {
          ForEach(1...100, id: \.self) { count in
            Text("Placeholder \(count)")
              .foregroundColor(Color.white)
              .background(Color.blue)
          }
        }
      }
      
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(alignment: .center, spacing: 20, pinnedViews: [.sectionHeaders, .sectionFooters]) {
          Section(
            header: Text("Header").background(Color.orange),
            footer: Text("Footer").background(Color.orange)) {
            ForEach(1...100, id: \.self) { count in
              Text("Placeholder \(count)")
                .foregroundColor(Color.white)
                .background(Color.blue)
            }
          }
        }
      }
    }
  }
}

struct LazyHStackView_Previews: PreviewProvider {
  static var previews: some View {
    LazyHStackView()
  }
}
