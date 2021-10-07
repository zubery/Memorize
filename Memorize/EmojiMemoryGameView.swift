//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Ryan Zubery on 6/1/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("Memorize: " + game.themeName)
                .font(.largeTitle)
                .foregroundColor(.blue)
            AspectVGrid(items: game.cards, aspectRatio: 13/21) { card in
                CardView(card: card, color: game.themeColor)
                    .padding(5)
                    .onTapGesture {
                        game.choose(card)
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
            game.newGame()
        } label: {
            Image(systemName: "arrow.counterclockwise.circle")
        }
    }
    
    var score: some View {
        var scoreString = String(format: "%.2f", game.score)
        
        if game.score > 0 {
            scoreString = "+" + scoreString
        }
        
        let scoreColor = game.score >= 0 ? Color.green : Color.red
        
        return Text(scoreString).foregroundColor(scoreColor)
    }
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    let color: LinearGradient
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill(Color.white)
                    // TODO: Should border be thicker/colored?
                    shape.strokeBorder()
                    // TODO: Clean up magic numbers
                    Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: 120 - 90)).padding(5).opacity(0.5)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                }
                else {
                    shape.fill(color)
                }
            }
        })
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let fontScale: CGFloat = 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
    }
}
