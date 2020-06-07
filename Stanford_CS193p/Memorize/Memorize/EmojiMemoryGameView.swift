//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by keisme on 2020/5/31.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
  @ObservedObject var viewModel: EmojiMemoryGame
  
  var body: some View {
    HStack {
      Grid(viewModel.cards) { card in
        CardView(card: card).onTapGesture {
          self.viewModel.choose(card: card)
        }
      .padding()
      }
    }
    .padding()
    .foregroundColor(.orange)
    .font(.largeTitle)
  }
}

struct CardView: View {
  var card: MemoryGame<String>.Card
  
  var body: some View {
    GeometryReader { geo in
      self.body(for: geo.size)
    }
  }
  
  func body(for size: CGSize) -> some View {
    ZStack {
      if card.isFaceUp {
        RoundedRectangle(cornerRadius: cornerRadius)
          .stroke(lineWidth: edgeLineWidth)
        Text(card.content)
      } else {
        RoundedRectangle(cornerRadius: cornerRadius).fill()
      }
    }
    .font(Font.system(size: fontSize(for: size)))
  }
  
  // MARK: - Drawing Constants
  
  let cornerRadius: CGFloat = 10.0
  let edgeLineWidth: CGFloat = 3
  let fontScaleFactor: CGFloat = 0.75
  func fontSize(for size: CGSize) -> CGFloat {
    min(size.width, size.height) * fontScaleFactor
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
  }
}
