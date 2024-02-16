//
//  ContentView.swift
//  Memorize
//
//  Created by Daianne Aguiar on 16/02/24.
//

import SwiftUI

// "🌼","🌹","🍁","🌵","🌻","🌳","🌷","🌺"
// "🎄","🎁","✝️","🤶🏻","👨‍👩‍👦‍👦","❄️","🎠"
// "😈","☠️","🫥","🕸️","👹","😱"

struct EmojiMemoryGameView: View {
    let halloween = ["👻","🎃","🕷️","💀"]
    let spring = ["🍀","🌸"]
    let christimans = ["🧑🏻‍🎄","🎅🏼","☃️"]
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack{
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }
            Divider()
            startGameButton
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [
            GridItem(.adaptive(minimum: 80), spacing: 0)
        ], spacing: 0) {
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
            .foregroundColor(.orange)
        }
    }
    
    var cardCountAdjusters: some View {
        HStack {
            themeHalloweenSelect
            themeSpringSelect
            themeChristimansSelect
        }
        .font(.largeTitle)
        .foregroundColor(.black)
    }
    
    func cardThemeAjuster(by theme: Array<String>, symbol: String, counter: Int, title: String) -> some View {
        VStack{
            Button(action: {
                //
            }, label: {
                Text(symbol)
            })
            Text(title).font(.subheadline).foregroundColor(.orange)
        }
    }
    
    var themeSpringSelect: some View {
        return cardThemeAjuster(by: spring, symbol: "🌻", counter: 4, title: "spring")
    }
    
    var themeChristimansSelect: some View {
        cardThemeAjuster(by: christimans, symbol: "🎅🏼", counter: 6, title: "natal")
    }
    
    var themeHalloweenSelect: some View {
        cardThemeAjuster(by: halloween, symbol: "👻", counter: 8, title: "horror")
    }
    
    var startGameButton: some View {
        Button(action: {
            viewModel.shuffle()
        }, label: {
            Text("shuffle").bold().font(.body)
        })
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
