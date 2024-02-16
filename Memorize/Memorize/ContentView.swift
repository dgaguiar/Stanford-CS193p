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

struct ContentView: View {
    let halloween = ["👻","🎃","🕷️","💀"]
    let spring = ["🍀","🌸"]
    let christimans = ["🧑🏻‍🎄","🎅🏼","☃️"]
    
    @State var cardCount: Int = 8
    @State var themeList: Array<String> = ["👻","🎃","🕷️","💀","👻","🎃","🕷️","💀"]
    @State var indexesAdd: Array<Int> = []
    @State var dropCards = false
    
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
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: themeList[index], isFaceUp: dropCards)
                    .aspectRatio(2/3, contentMode: .fit)
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
                themeList = theme + theme
                themeList.shuffle()
                cardCount = counter
            }, label: {
                Text(symbol)
            })
            Text(title).font(.subheadline).foregroundColor(.orange)
        }
    }
    
    var themeSpringSelect: some View {
        cardThemeAjuster(by: spring, symbol: "🌻", counter: 4, title: "spring")
    }
    
    var themeChristimansSelect: some View {
        cardThemeAjuster(by: christimans, symbol: "🎅🏼", counter: 6, title: "natal")
    }
    
    var themeHalloweenSelect: some View {
        cardThemeAjuster(by: halloween, symbol: "👻", counter: 8, title: "horror")
    }
    
    var startGameButton: some View {
        Button(action: {
            themeList.shuffle()
            dropCards = true
        }, label: {
            Text("embaralhar").bold().font(.body)
        })
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    @State var notFound = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1: 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            if notFound {
                isFaceUp.toggle()
            }
        }
    }
}

#Preview {
    ContentView()
}
