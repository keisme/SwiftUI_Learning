//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by keisme on 2020/6/2.
//  Copyright © 2020 JFF147. All rights reserved.
//

import SwiftUI

/// ViewModel
class EmojiMemoryGame: ObservableObject {
  @Published private var model: MemoryGame<String> = createMemoryGame()
  
  static func createMemoryGame() -> MemoryGame<String> {
    let emojis: [String] = ["🐋", "🦜", "🐟"]
    return MemoryGame<String>(numberOfParisOfCards: emojis.count) { index in
      return emojis[index]
    }
  }
  
  // MARK: - Acess to the Model
  
  var cards: [MemoryGame<String>.Card] {
    model.cards
  }
  
  // MARK: - Intent(s)
  func choose(card: MemoryGame<String>.Card) {
    model.choose(card: card)
  }
}
