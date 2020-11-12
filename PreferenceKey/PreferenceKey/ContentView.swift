//
//  ContentView.swift
//  PreferenceKey
//
//  Created by Bruce on 2020/11/11.
//

import SwiftUI

struct ContentView : View {
  
  @State private var email = ""
  @State private var password = ""
  @State private var textWidth: CGFloat?
  
  var body: some View {
    Form {
      HStack {
        Text("电子邮箱")
          .frame(width: textWidth, alignment: .leading)
          .background(TextBackgroundView())
        TextField("请输入", text: $email)
          .textFieldStyle(RoundedBorderTextFieldStyle())
      }
      
      HStack {
        Text("密码")
          .frame(width: textWidth, alignment: .leading)
          .background(TextBackgroundView())
        TextField("请输入", text: $email)
          .textFieldStyle(RoundedBorderTextFieldStyle())
      }
    }
    .onPreferenceChange(TextWidthPreferenceKey.self) { (value) in
      print(value)
      textWidth = value.max()
    }
  }
}

struct TextBackgroundView: View {
  var body: some View {
    GeometryReader { gr in
      Rectangle()
        .fill(Color.clear)
        .preference(key: TextWidthPreferenceKey.self,
                    value: [gr.size.width])
    }
  }
}

struct TextWidthPreferenceKey: PreferenceKey {
  static var defaultValue: [CGFloat] = []

  static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
    value.append(contentsOf: nextValue())
  }
}
