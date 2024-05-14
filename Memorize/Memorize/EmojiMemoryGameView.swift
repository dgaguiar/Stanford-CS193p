//
//  ContentView.swift
//  Memorize
//
//  Created by Daianne Aguiar on 16/02/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var themes = [
        MemoryGame<String>.Theme.themeHorror(),
        MemoryGame<String>.Theme.themeSpring(),
        MemoryGame<String>.Theme.themeSign(),
        MemoryGame<String>.Theme.themeChristimans()
    ]
    
    var body: some View {
        VStack{
            title
            cards
                .animation(.default, value: viewModel.cards)
            Divider()
            HStack {
                startGameButton
                Spacer()
                newGameButton
            }
            
            Spacer()
        }
        .padding()
    }
    
    var cards: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: viewModel.cards.count,
                size: geometry.size,
                atAspectRatio: 2/3)
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: gridItemSize), spacing: 0)
            ], spacing: 0) {
                ForEach(viewModel.cards) { card in
                    CardView(card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
            .foregroundColor(viewModel.theme.color)
        }
    }
    
    func gridItemWidthThatFits(
        count: Int,
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat) -> CGFloat {
            let count = CGFloat(count)
            var columnCount = 1.0
            repeat {
                let width = size.width / columnCount
                let height = width / aspectRatio
                let rowCount = ( count / columnCount).rounded(.up)
                
                if rowCount * height < size.height {
                    return (size.width / columnCount).rounded(.down )
                }
                columnCount += 1
                
            } while columnCount.rounded(.down) < count
            return min(size.width / count, size.height * aspectRatio).rounded(.down)
        }
    
    func cardThemeAjuster(by theme: MemoryGame<String>.Theme, symbol: String, counter: Int, title: String) -> some View {
        VStack{
            Button(action: {
                viewModel.choose(theme)
            }, label: {
                Text(symbol)
            })
            Text(title).font(.subheadline).foregroundColor(.orange)
        }
    }
    
    var title: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            Text(viewModel.theme.name).font(.title2).foregroundColor(.gray)
        }
    }
    
    var startGameButton: some View {
        Button(action: {
            viewModel.shuffle()
        }, label: {
            Text("shuffle").bold().font(.title2)
        })
    }
    
    var newGameButton: some View {
        Button(action: {
            viewModel.choose(themes[Int.random(in: 0..<themes.count)])
            viewModel.shuffle()
        }, label: {
            Text("new game").bold().font(.title2)
        })
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
