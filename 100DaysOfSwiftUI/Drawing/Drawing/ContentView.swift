//
//  ContentView.swift
//  Drawing
//
//  Created by Bruce on 2020/5/14.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

struct Triangle: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
    
    return path
  }
}

struct InsettableArc: InsettableShape {
  var startAngle: Angle
  var endAngle: Angle
  var clockwise: Bool
  var insetAmount: CGFloat = 0
  
  func path(in rect: CGRect) -> Path {
    let rotationAdjustment = Angle.degrees(90)
    let modifiedStart = startAngle - rotationAdjustment
    let modifiedEnd = endAngle - rotationAdjustment
    
    var path = Path()
    path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
    
    return path
  }
  
  func inset(by amount: CGFloat) -> some InsettableShape {
    var arc = self
    arc.insetAmount += amount
    return arc
  }
}

struct Flower: Shape {
  var petalOffset: Double = -20
  var petalWidth: Double = 100
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8) {
      let rotation = CGAffineTransform(rotationAngle: number)
      let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
      let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))
      let rotatedPetal = originalPetal.applying(position)
      path.addPath(rotatedPetal)
    }
    
    return path
  }
}

struct ColorCyclingCircle: View {
  var amount = 0.0
  var steps = 100
  
  var body: some View {
    ZStack {
      ForEach(0..<steps) { value in
        Circle()
          .inset(by: CGFloat(value))
          //          .strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
          .strokeBorder(LinearGradient(gradient: Gradient(colors: [
            self.color(for: value, brightness: 1),
            self.color(for: value, brightness: 0.5)
          ]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
      }
    }
    .drawingGroup()
  }
  
  func color(for value: Int, brightness: Double) -> Color {
    var targetHue = Double(value) / Double(self.steps) + self.amount
    
    if targetHue > 1 {
      targetHue -= 1
    }
    
    return Color(hue: targetHue, saturation: 1, brightness: brightness)
  }
}

struct Trapezoid: Shape {
  var insetAmount: CGFloat
  var animatableData: CGFloat {
    get { insetAmount }
    set { self.insetAmount = newValue }
  }
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    path.move(to: CGPoint(x: 0, y: rect.maxY))
    path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    path.addLine(to: CGPoint(x: 0, y: rect.maxY))
    
    return path
  }
}

struct Checkerboard: Shape {
  var rows: Int
  var columns: Int
  
  
  public var animatableData: AnimatablePair<Double, Double> {
    get {
      AnimatablePair(Double(rows), Double(columns))
    }
    
    set {
      self.rows = Int(newValue.first)
      self.columns = Int(newValue.second)
    }
  }
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    // figure out how big each row/column needs to be
    let rowSize = rect.height / CGFloat(rows)
    let columnSize = rect.width / CGFloat(columns)
    
    // loop over all rows and columns, making alternating squares colored
    for row in 0..<rows {
      for column in 0..<columns {
        if (row + column).isMultiple(of: 2) {
          // this square should be colored; add a rectangle here
          let startX = columnSize * CGFloat(column)
          let startY = rowSize * CGFloat(row)
          
          let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
          path.addRect(rect)
        }
      }
    }
    
    return path
  }
}

struct Spirograph: Shape {
  let innerRadius: Int
  let outerRadius: Int
  let distance: Int
  let amount: CGFloat
  
  func path(in rect: CGRect) -> Path {
    let divisor = gcd(innerRadius, outerRadius)
    let outerRadius = CGFloat(self.outerRadius)
    let innerRadius = CGFloat(self.innerRadius)
    let distance = CGFloat(self.distance)
    let difference = innerRadius - outerRadius
    let endPoint = ceil(2 * CGFloat.pi * outerRadius / CGFloat(divisor)) * amount
    
    var path = Path()
    
    for theta in stride(from: 0, through: endPoint, by: 0.01) {
      var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
      var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)
      
      x += rect.width / 2
      y += rect.height / 2
      
      if theta == 0 {
        path.move(to: CGPoint(x: x, y: y))
      } else {
        path.addLine(to: CGPoint(x: x, y: y))
      }
    }
    
    return path
  }
  
  func gcd(_ a: Int, _ b: Int) -> Int {
    var a = a
    var b = b
    
    while b != 0 {
      let temp = b
      b = a % b
      a = temp
    }
    
    return a
  }
}

struct ContentView: View {
  @State private var petalOffset = -20.0
  @State private var petalWidth = 100.0
  @State private var colorCycle = 0.0
  @State private var amount: CGFloat = 0.0
  @State private var insetAmount: CGFloat = 50
  @State private var rows = 4
  @State private var columns = 4
  
  var body: some View {
    ScrollView {
      VStack {
        Flower(petalOffset: petalOffset, petalWidth: petalWidth)
          .fill(Color.blue, style: FillStyle(eoFill: true))
        
        Text("Offset")
        Slider(value: $petalOffset, in: -40...40)
          .padding([.horizontal, .bottom])
        
        Text("Width")
        Slider(value: $petalWidth, in: 0...100)
          .padding(.horizontal)
      }
      
      VStack {
        Text("Hello World")
          .frame(width: 300, height: 300)
          .border(ImagePaint(image: Image("Estonia"), scale: 1), width: 50)
        
        Capsule()
          .strokeBorder(ImagePaint(image: Image("Estonia"), scale: 1), lineWidth: 20)
          .frame(width: 300, height: 200)
      }
      
      
      VStack {
        ColorCyclingCircle(amount: self.colorCycle)
          .frame(width: 300, height: 300)
        
        Slider(value: $colorCycle)
      }
      
      ZStack {
        Image("Estonia")
          .colorMultiply(Color.white)
        
        Rectangle()
          .fill(Color.red)
          .blendMode(.multiply)
      }
      .frame(width: 400, height: 500)
      .clipped()
      
      VStack {
        ZStack {
          Circle()
            .fill(Color.red)
            .frame(width: 200 * amount)
            .offset(x: -50, y: -80)
            .blendMode(.screen)
          
          Circle()
            .fill(Color.green)
            .frame(width: 200 * amount)
            .offset(x: 50, y: -80)
            .blendMode(.screen)
          
          Circle()
            .fill(Color.blue)
            .frame(width: 200 * amount)
            .blendMode(.screen)
        }
        .frame(width: 300, height: 300)
        
        Slider(value: $amount)
          .padding()
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.black)
      .edgesIgnoringSafeArea(.all)
      
      Image("Estonia")
        .resizable()
        .scaledToFit()
        .frame(width: 200, height: 200)
        .saturation(Double(amount))
        .blur(radius: (1 - amount) * 20)
      
      Trapezoid(insetAmount: insetAmount)
        .frame(width: 200, height: 100)
        .onTapGesture {
          withAnimation {
            self.insetAmount = CGFloat.random(in: 10...90)
          }
      }
      
      Checkerboard(rows: rows, columns: columns)
        .onTapGesture {
          withAnimation(.linear(duration: 3)) {
            self.rows = 8
            self.columns = 16
          }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
