//
//  ContentView.swift
//  Flashzilla
//
//  Created by keisme on 2020/5/26.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {
  @State private var cards = [Card](repeating: Card.example, count: 10)
  @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor

  func removeCard(at index: Int) {
    cards.remove(at: index)
  }
  
  var body: some View {
    ZStack {
      Image(decorative: "background")
        .resizable()
        .scaledToFill()
        .edgesIgnoringSafeArea(.all)
      
      VStack {
        ZStack {
          ForEach(0..<cards.count, id: \.self) { index in
            CardView(card: self.cards[index]) {
              withAnimation {
                self.removeCard(at: index)
              }
            }
            .stacked(at: index, in: self.cards.count)
          }
        }
      }
      
      if differentiateWithoutColor {
        VStack {
          Spacer()
          
          HStack {
            Image(systemName: "xmark.circle")
              .padding()
              .background(Color.black.opacity(0.7))
              .clipShape(Circle())
            Spacer()
            Image(systemName: "checkmark.circle")
              .padding()
              .background(Color.black.opacity(0.7))
              .clipShape(Circle())
          }
          .foregroundColor(.white)
          .font(.largeTitle)
          .padding()
        }
      }
    }
  }
}

extension View {
  func stacked(at position: Int, in total: Int) -> some View {
    let offset = CGFloat(total - position)
    return self.offset(CGSize(width: 0, height: offset * 10))
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

