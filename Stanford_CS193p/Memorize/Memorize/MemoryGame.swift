//
//  MemoryGame.swift
//  Memorize
//
//  Created by keisme on 2020/6/2.
//  Copyright © 2020 JFF147. All rights reserved.
//

import Foundation

/// Model
struct MemoryGame<CardContent> {
  var cards: [Card]
  
  mutating func choose(card: Card) {
    let chosenIndex: Int = self.cards.firstIndex(where: { $0.id == card.id })!
    self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp
  }
  
  init(numberOfParisOfCards: Int, cardContentFactory: (Int) -> CardContent) {
    cards = [Card]()
    for pairIndex in 0..<numberOfParisOfCards {
      let content = cardContentFactory(pairIndex)
      cards.append(Card(content: content))
      cards.append(Card(content: content))
    }
  }
  
  struct Card: Identifiable {
    var id = UUID()
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    var content: CardContent
  }
}
