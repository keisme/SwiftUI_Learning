//
//  Checkbox.swift
//  Animation
//
//  Created by Bruce on 2020/8/13.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

struct Checkbox: View {
  
  @State var checked = false
  @State var trimVal: CGFloat = 0
  
  @Namespace var nsAnimation
  
  var body: some View {
    VStack {
      Button (action: {
        if checked {
          withAnimation {
            self.checked.toggle()
            self.trimVal = 0
          }
        } else {
          withAnimation(Animation.easeIn(duration: 0.8)) {
            self.checked.toggle()
            self.trimVal = 1
          }
        }
      }) {
        Checkbox1(checked: $checked, trimVal: $trimVal)
      }
    }
  }
}

struct Checkbox1: View {
  @Binding var checked: Bool
  @Binding var trimVal: CGFloat
  
  var body: some View {
    ZStack {
      Circle()
        .trim(from: 0, to: trimVal)
        .stroke(style: StrokeStyle(lineWidth: 2))
        .frame(width: 80, height: 80)
        .foregroundColor(.green)
      
      Circle()
        .frame(width: 70, height: 70)
        .foregroundColor(checked ? .green : Color.gray.opacity(0.5))
      
      if checked {
        Image(systemName: "checkmark")
          .foregroundColor(.white)
      }
    }
  }
}

struct Checkbox2: View {
  var checked: Bool
  var trimVal: CGFloat
  
  var body: some View {
    ZStack {
      Circle()
        .trim(from: 0, to: trimVal)
        .stroke(style: StrokeStyle(lineWidth: 2))
        .frame(width: 80, height: 80)
        .foregroundColor(.green)
      
      Circle()
        .frame(width: 70, height: 70)
        .foregroundColor(checked ? .green : Color.gray.opacity(0.5))
      
      if checked {
        Image(systemName: "checkmark")
          .foregroundColor(.white)
      }
    }
  }
}
