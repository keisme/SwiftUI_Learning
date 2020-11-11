//
//  ContentView.swift
//  GeometryReader
//
//  Created by Bruce on 2020/11/11.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack(spacing: 10) {
      text("Top", width: 100, height: 50)
      
      HStack(spacing: 10) {
        text("Left", width: 50, height: 100)
        roundRect
          .background(Color.black)
        text("Right", width: 50, height: 100)
      }
      
      text("Bottom", width: 100, height: 50)
    }
    .coordinateSpace(name: "VStack")
  }
  
  var roundRect: some View {
    GeometryReader { gr in
      RoundedRectangle(cornerRadius: 10)
        .fill(Color.blue)
        .frame(width: gr.size.width * 0.5, height: gr.size.height * 0.5)
        .position(x: gr.frame(in: .local).midX, y: gr.frame(in: .local).midY)
        .onTapGesture {
          print("screen: \(UIScreen.main.bounds)")
          print("global: \(gr.frame(in: .global))")
          print("local: \(gr.frame(in: .local))")
          print("custom: \(gr.frame(in: .named("VStack")))")
        }
    }
  }
  
  func text(_ text: String, width: CGFloat, height: CGFloat) -> some View {
    Text(text)
      .frame(width: width, height: height)
      .background(Color.orange)
      .cornerRadius(10)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
