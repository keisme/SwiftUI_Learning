//
//  CardView.swift
//  Flashzilla
//
//  Created by keisme on 2020/5/28.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

struct CardView: View {
  @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
  @State private var isShowingAnswer = false
  @State private var offset = CGSize.zero
  
  let card: Card
  var removal: (() -> Void)? = nil
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 25, style: .continuous)
        .fill(
          differentiateWithoutColor
            ? Color.white
            : Color.white
              .opacity(1 - Double(abs(offset.width / 50)))
      )
        .background(
          differentiateWithoutColor
            ? nil
            : RoundedRectangle(cornerRadius: 25, style: .continuous)
              .fill(offset.width > 0 ? Color.green : Color.red)
      )
        .shadow(radius: 10)
      
      VStack {
        Text(card.prompt)
          .font(.largeTitle)
          .foregroundColor(.black)
        
        if isShowingAnswer {
          Text(card.answer)
            .font(.title)
            .foregroundColor(.gray)
        }
      }
      .padding(20)
      .multilineTextAlignment(.center)
    }
    .frame(width: 450, height: 250)
    .rotationEffect(.degrees(Double(offset.width / 5)))
    .offset(x: offset.width * 5, y: 0)
    .opacity(2 - Double(abs(offset.width / 50)))
    .onTapGesture {
      self.isShowingAnswer.toggle()
    }
    .gesture(
      DragGesture()
        .onChanged { gesture in
          self.offset = gesture.translation
      }
        
      .onEnded { _ in
        if abs(self.offset.width) > 100 {
          // remove the card
          self.removal?()
          print("removed")
        } else {
          self.offset = .zero
        }
      }
    )
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    CardView(card: Card.example)
  }
}
