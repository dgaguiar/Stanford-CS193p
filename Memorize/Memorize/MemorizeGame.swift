//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Daianne Aguiar on 16/02/24.
//

import Foundation

/// This is my Model
struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        /// Array<Card>() == [Card]() == []
        cards = []
        // add numberOfPairsOfCards X 2 cards
        for pairIndedx in 0..<max(2, numberOfPairsOfCards) {
            let content: CardContent = cardContentFactory(pairIndedx)
            cards.append(Card(content: content, id: "\(pairIndedx+1)a"))
            cards.append(Card(content: content, id: "\(pairIndedx+1)b"))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { index in cards[index].isFaceUp }.only
            
            /// After tha Extension  Array using the code above
//            var faceUpCardIndices = cards.indices.filter { index in cards[index].isFaceUp }
//            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            
            /// The code below do the same thing that the code above but with more code
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    faceUpCardIndices.append(index)
//                }
//            }
//            if faceUpCardIndices.count == 1 {
//                return faceUpCardIndices.first
//            } else {
//                return nil
//            }
        }
        set {
            cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) }
            
            /// The code below do the same thing that the code above but with more code
//            for index in cards.indices {
//                if index == newValue {
//                    cards[index].isFaceUp = true
//                } else {
//                    cards[index].isFaceUp = false
//                }
//            }
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchingIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchingIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchingIndex].isMatched = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up": "down") \(isMatched ? "matched" : "")"
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
