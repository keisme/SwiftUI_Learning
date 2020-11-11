//
//  ContentView.swift
//  PreferenceKey
//
//  Created by Bruce on 2020/11/11.
//

import SwiftUI

struct ContentView : View {
  @State private var numberWidth = CGFloat.zero
  
  var numbers: [String] {
    var ans = [String]()
    for v in [3, 13, 53, 93, 133] {
      ans.append(String(Int(arc4random_uniform(10000000))*v))
    }
    return ans
  }
  
  var body: some View {
    Form {
      ForEach(numbers, id: \.self) { number in
        RowView(number: number)
      }
    }
    .onPreferenceChange(NumberWidthPreferenceKey.self) { (value) in
      print(value)
      numberWidth = value
    }
    .onTapGesture {
      print(numberWidth)
    }
  }
}

struct RowView: View {
  var number: String
  
  var body: some View {
    HStack {
      Text(number)
        .background(NumberBackgroundView())
        
      Text("xxx")
        .background(Color.orange)
    }
  }
}

struct NumberBackgroundView: View {
  var body: some View {
    GeometryReader { gr in
      Rectangle()
        .fill(Color.blue)
        .preference(key: NumberWidthPreferenceKey.self,
                    value: gr.size.width)
    }
  }
}

struct NumberWidthPreferenceKey: PreferenceKey {
  static var defaultValue: CGFloat = .zero
  
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = max(value, nextValue())
  }
}
