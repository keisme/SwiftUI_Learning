//
//  PathAnimation.swift
//  Animation
//
//  Created by Bruce on 2020/7/2.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

struct Triangle: Shape {
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: 0, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.midX, y: 0))
    path.closeSubpath()
    return path
  }
}

struct RingProgress: Shape {
  
  var progress: CGFloat
  
  var animatableData: CGFloat {
    get { progress }
    set { progress = newValue }
  }
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: 70, startAngle: .degrees(0), endAngle: .degrees(360.0 * Double(progress)), clockwise: false)
    return path
  }
}

struct Loading: Shape {
  
  var startAngle: Double = 0
  
  var animatableData: Double {
    get { startAngle }
    set { startAngle = newValue }
  }
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: 18, startAngle: .degrees(startAngle), endAngle: .degrees(60 + startAngle), clockwise: false)
    return path
  }
}

struct PathAnimation: View {
  @State private var percent: CGFloat = .zero
  @State private var progress: CGFloat = .zero
  @State private var startAngle: Double = .zero
  
  var body: some View {
    VStack {
      Triangle()
        .trim(from: 0, to: percent)
        .stroke(Color.blue, style: .init(lineWidth: 8, lineCap: .round, lineJoin: .round))
        .frame(width: 147, height: 147)
        .onAppear {
          withAnimation(.easeInOut(duration: 3)) {
            self.percent = 1
          }
        }
      
      ZStack {
        Color.black
        
        RingProgress(progress: progress)
          .stroke(Color.blue, style: .init(lineWidth: 8, lineCap: .round, lineJoin: .round))
          .animation(.default)
        
        Text("Tap Me")
          .foregroundColor(.white)
      }
      .onTapGesture {
        self.progress += 0.1
      }
      
      Loading(startAngle: startAngle)
        .stroke(Color.blue, style: .init(lineWidth: 3, lineCap: .round, lineJoin: .round))
        .onAppear {
          withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
            self.startAngle = 360
          }
        }
    }
  }
}
