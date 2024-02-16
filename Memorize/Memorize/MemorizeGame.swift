//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Daianne Aguiar on 16/02/24.
//

import Foundation

/// This is my Model
struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        /// Array<Card>() == [Card]() == []
        cards = []
        // add numberOfPairsOfCards X 2 cards
        for pairIndedx in 0..<max(2, numberOfPairsOfCards) {
            let content: CardContent = cardContentFactory(pairIndedx)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card) {
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card {
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    }
}
