//
//  PathAnimation.swift
//  Animation
//
//  Created by Bruce on 2020/7/2.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

struct Triangle: Shape {
  var percent: CGFloat
  
  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: 0, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.midX, y: 0))
    path.closeSubpath()
    return path
  }
}

struct PathAnimation: View {
//  @State private var percent: CGFloat
//
//  var body: some View {
//    ScrollView {
//      Triangle(percent: percent)
//        .onAppear {
//          self.percent = 1
//      }
//    }
//  }
  

  var height: CGFloat
  var width: CGFloat

  @State private var percentage: CGFloat = .zero
  
  var body: some View {

      // ZStack {         // as for me, looks better w/o stack which tighten path
          Path { path in
              path.move(to: CGPoint(x: 0, y: height/2))
              path.addLine(to: CGPoint(x: width/2, y: height))
              path.addLine(to: CGPoint(x: width, y: 0))
          }
          .trim(from: 0, to: percentage) // << breaks path by parts, animatable
          .stroke(Color.black, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
          .animation(.easeOut(duration: 2.0)) // << animate
          .onAppear {
              self.percentage = 1.0 // << activates animation for 0 to the end
          }

      //}
  }
}
