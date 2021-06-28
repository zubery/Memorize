//
//  ContentView.swift
//  Memorize
//
//  Created by Ryan Zubery on 6/1/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("Memorize: " + viewModel.themeName)
                .font(.largeTitle)
                .foregroundColor(.blue)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card, color: viewModel.themeColor)
                            .aspectRatio(13/21, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            Spacer()
            HStack(alignment: .bottom) {
                newGame
                Spacer()
                score
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding()
    }
    
    var newGame: some View {
        Button {
            viewModel.newGame()
        } label: {
            Image(systemName: "arrow.counterclockwise.circle")
        }
    }
    
    var score: some View {
        var scoreString = String(format: "%.2f", viewModel.score)
        
        if viewModel.score > 0 {
            scoreString = "+" + scoreString
        }
        
        let scoreColor = viewModel.score >= 0 ? Color.green : Color.red
        
        return Text(scoreString).foregroundColor(scoreColor)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    let color: LinearGradient
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25.0)
            if card.isFaceUp {
                shape.fill(Color.white)
                shape.strokeBorder()
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            }
            else {
                shape.fill(color)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
