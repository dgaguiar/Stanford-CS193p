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

    private static func createMemoryGame() -> MemoryGame<String> {
        return  MemoryGame(MemoryGame.Theme.themeHorror())
    }
    
    /// when you put `private` only the class who the `var` belong can use it
    ///  `@Published` means send that somethign change
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var theme: MemoryGame<String>.Theme {
        return model.theme
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func choose(_ theme: MemoryGame<String>.Theme) {
        model = MemoryGame(theme)
    }
}
