//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Daianne Aguiar on 16/02/24.
//

import SwiftUI


/// This is my ViewModel
class EmojiMemoryGame: ObservableObject {
    // MARK: Static
    /// is global to this class
    private static let emojis = ["👻","🎃","🕷️","💀","😈","☠️","🫥","🕸️","👹","😱","🧙🏻‍♀️"]

    private static func createMemoryGame() -> MemoryGame<String> {
        return  MemoryGame(numberOfPairsOfCards: 4) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    /// when you put `private` only the class who the `var` belong can use it
    ///  `@Published` means send that somethign change
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
