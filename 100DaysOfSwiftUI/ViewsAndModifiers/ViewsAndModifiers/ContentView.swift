//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Bruce on 2020/5/8.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var useRedText = false
  
  var body: some View {
    ScrollView {
      Text("Hello, World!")
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color.red)
        .edgesIgnoringSafeArea(.all)
      
      Button("Hello world") {
        print(type(of: self.body))
        self.useRedText.toggle()
      }
      .frame(width: 200, height: 200, alignment: .center)
      .foregroundColor(useRedText ? .red : .blue)
      .background(Color.red)
      
      Text("Hello World")
        .padding(10)
        .background(Color.red)
        .padding(20)
        .background(Color.blue)
        .padding(30)
        .background(Color.green)
        .padding(40)
        .background(Color.yellow)
      
      VStack {
        Text("Gryffindor")
          .font(.largeTitle)
        Text("Hufflepuff")
          .blur(radius: 0)
        Text("Ravenclaw")
        Text("Slytherin")
      }
      .font(.title)
      .blur(radius: 2)
      
      VStack(spacing: 10) {
        CapsuleText(text: "First")
          .foregroundColor(.white)
        CapsuleText(text: "Second")
          .foregroundColor(.black)
      }
      
      Text("Hello world")
        .titleStyle()
      
      Color.blue
        .frame(width: 300, height: 200)
        .watermarked(with: "JFF147")
      
      GridStack(rows: 5, columns: 4) { row, col in
        Image(systemName: "\(row * 4 + col).circle")
        Text("R\(row) C\(col)")
          .background(Color.red)
      }
    }
  }
}

struct GridStack<Content: View>: View {
  let rows: Int
  let columns: Int
  let content: (Int, Int) -> Content
  
  init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
      self.rows = rows
      self.columns = columns
      self.content = content
  }
  
  var body: some View {
    VStack {
      ForEach(0..<rows, id: \.self) { row in
        HStack {
          ForEach(0..<self.columns, id: \.self) { column in
            self.content(row, column)
          }
        }
      }
    }
  }
}

struct Watermark: ViewModifier {
  var text: String
  
  func body(content: Content) -> some View {
    ZStack(alignment: .bottomTrailing) {
      content
      Text(text)
        .font(.title)
        .foregroundColor(.white)
        .padding(5)
        .background(Color.black)
        .cornerRadius(radius: 8, corners: [.topLeft])
    }
  }
}

extension View {
  func watermarked(with text: String) -> some View {
    self.modifier(Watermark(text: text))
  }
}

struct CornerRadiusStyle: ViewModifier {
  var radius: CGFloat
  var corners: UIRectCorner
  
  struct CornerRadiusShape: Shape {
    
    var radius = CGFloat.infinity
    var corners = UIRectCorner.allCorners
    
    func path(in rect: CGRect) -> Path {
      let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
      return Path(path.cgPath)
    }
  }
  
  func body(content: Content) -> some View {
    content
      .clipShape(CornerRadiusShape(radius: radius, corners: corners))
  }
}

extension View {
  func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
    ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
  }

  func titleStyle() -> some View {
    self.modifier(Title())
  }
}

struct CapsuleText: View {
  var text: String
  
  var body: some View {
    Text(text)
      .font(.largeTitle)
      .padding()
      .background(Color.blue)
      .clipShape(Capsule())
  }
}

struct Title: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.largeTitle)
      .foregroundColor(.white)
      .padding()
      .background(Color.blue)
      .clipShape(RoundedRectangle(cornerRadius: 10))
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
