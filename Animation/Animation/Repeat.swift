//
//  Repeat.swift
//  Animation
//
//  Created by Bruce on 2020/7/1.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

struct Repeat: View {
  
  @State private var animationAmount: CGFloat = 1
  
  var body: some View {
    VStack {
      Button("Tap Me") {
        self.animationAmount += 1
      }
      .frame(width: 100, height: 100)
      .background(Color.red)
      .foregroundColor(.white)
      .clipShape(Circle())
      .scaleEffect(animationAmount)
      .animation(
        Animation.easeIn(duration: 1)
          .repeatForever()
      )
      
      Spacer()
      
      Button("Hello") {
        
      }
      .padding(40)
      .background(Color.red)
      .foregroundColor(.white)
      .clipShape(Circle())
      .overlay(
          Circle()
              .stroke(Color.red)
              .scaleEffect(animationAmount)
              .opacity(Double(2 - animationAmount))
              .animation(
                  Animation.easeOut(duration: 1)
                      .repeatForever(autoreverses: false)
              )
      )
      .onAppear {
          self.animationAmount = 2
      }
    }
  }
}

struct Example1_Previews: PreviewProvider {
  static var previews: some View {
    Repeat()
  }
}
