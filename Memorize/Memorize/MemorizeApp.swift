//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Daianne Aguiar on 16/02/24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
