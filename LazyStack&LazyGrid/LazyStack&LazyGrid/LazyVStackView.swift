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
        LazyVStack(spacing: 20) {
          ForEach(1...100, id: \.self) { count in
            Text("Placeholder \(count)")
              .foregroundColor(Color.white)
              .background(Color.blue)
          }
        }
      }
      
      Divider()
      
      ScrollView(showsIndicators: false) {
        LazyVStack(alignment: .center, spacing: 20, pinnedViews: [.sectionHeaders, .sectionFooters]) {
          Section(
            header: Text("Header")
              .padding()
              .frame(maxWidth: .infinity)
              .background(Color.orange),
            footer: Text("Footer")
              .padding()
              .frame(maxWidth: .infinity)
              .background(Color.orange)) {
            ForEach(1...100, id: \.self) { count in
              Text("Placeholder \(count)")
                .foregroundColor(Color.white)
                .background(Color.blue)
            }
          }
        }
      }
      .edgesIgnoringSafeArea(.all)
      .navigationTitle("LazyVStack")
    }
  }
}

struct LazyVStackView_Previews: PreviewProvider {
  static var previews: some View {
    LazyVStackView()
  }
}
