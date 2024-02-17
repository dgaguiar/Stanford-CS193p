//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Daianne Aguiar on 16/02/24.
//

import Foundation
import SwiftUI

/// This is my Model
struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var theme = MemoryGame.Theme.themeHorror()
    
    init(_ theme: Theme) {
        cards = []
        self.theme = theme
        // add numberOfPairsOfCards X 2 cards
        for pairIndedx in 0..<max(2, theme.numberOfPairs) {
            cards.append(Card(content: theme.emoji[pairIndedx] as! CardContent, id: "\(pairIndedx+1)a"))
            cards.append(Card(content: theme.emoji[pairIndedx] as! CardContent, id: "\(pairIndedx+1)b"))
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { index in cards[index].isFaceUp }.only
        }
        set {
            cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) }
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
    
    struct Theme {
        let name: String
        let emoji: [String]
        var numberOfPairs: Int
        let color: Color
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}

extension MemoryGame.Theme {
    static func themeSpring() -> MemoryGame.Theme {
        return MemoryGame.Theme(name: PersonThemes.spring.rawValue,
                                emoji: ["🍀","🌸","🌼","🌹","🍁","🌵","🌻","🌳","🌷","🌺"],
                                numberOfPairs: 10,
                                color: .green)
    }
    
    static func themeChristimans() -> MemoryGame.Theme {
        return MemoryGame.Theme(name: PersonThemes.christimans.rawValue,
                                emoji: ["🧑🏻‍🎄","🎅🏼","☃️","🎄","🎁","✝️","🤶🏻","👨‍👩‍👦‍👦","❄️","🎠"],
                                numberOfPairs: 10,
                                color: .red)
    }
    
    static func themeSign() -> MemoryGame.Theme {
        return MemoryGame.Theme(name: PersonThemes.sign.rawValue,
                                emoji: ["🚺","🚹","⚠️","🔞","🛄","🛜","♻️"],
                                numberOfPairs: 7,
                                color: .orange)
    }
    
    static func themeHorror() -> MemoryGame.Theme {
        return MemoryGame.Theme(name: PersonThemes.horror.rawValue,
                                emoji: ["👻","🎃","🕷️","💀","😈","☠️","🫥","🕸️","👹","😱","🧙🏻‍♀️"],
                                numberOfPairs: 11,
                                color: .black)
    }
}

enum PersonThemes: String {
    case spring = "spring"
    case christimans = "christimans"
    case horror = "Helloween"
    case sign = "sign"
}
