//
//  LazyHGridView.swift
//  LazyStack&LazyGrid
//
//  Created by Bruce on 2020/7/22.
//

import SwiftUI

struct LazyHGridView: View {
  private let weathers = ["sun.max", "moon", "cloud.drizzle", "snow", "wind.snow"]
  private let rowStyles = ["adaptive", "fixed", "flexible", "mix1", "mix2", "mix3"]
  @State private var selection: Int = 0
  private let rows = [
    [GridItem(.adaptive(minimum: 60))],
    Array(repeating: GridItem(.fixed(80)), count: 3),
    Array(repeating: GridItem(.flexible(minimum: 60)), count: 3),
    [GridItem(.fixed(100)), GridItem(.adaptive(minimum: 50))],
    [GridItem(.fixed(80)), GridItem(.flexible(minimum: 60))],
    [GridItem(.fixed(120)), GridItem(.flexible(maximum: 80)), GridItem(.adaptive(minimum: 40))]
  ]
  
  var body: some View {
    VStack {
      Picker("RowStyles", selection: $selection) {
        ForEach(0..<rowStyles.count) { i in
          Text(rowStyles[i]).tag(i)
        }
      }
      .pickerStyle(SegmentedPickerStyle())
      
      ScrollView(.horizontal) {
        LazyHGrid(rows: rows[selection]) {
          ForEach(0..<999) { i in
            Image(systemName: weathers[i % weathers.count])
              .font(.title)
              .frame(minWidth: 40, maxWidth: .infinity, maxHeight: .infinity)
              .foregroundColor(Color.white)
              .background(Color.blue)
              .cornerRadius(8)
          }
        }
      }
      .frame(maxHeight: .infinity)
    }
    .navigationTitle("LazyHGrid")
  }
}

struct LazyHGrid_Previews: PreviewProvider {
  static var previews: some View {
    LazyHGridView()
  }
}
