//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ryan Zubery on 6/19/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    // MARK: - Type Variables and Functions
    static let fruitTheme = MemoryGameTheme<String>(name: "Fruit", cardContent: ["🍏", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝"], colors: ["pink", "purple"])
    static let catTheme = MemoryGameTheme<String>(name: "Cats", cardContent: ["😹", "😻", "🙀", "😿", "😽", "😸", "🐱", "😾", "😼"], pairsOfCards: 6, colors: ["orange", "yellow"])
    static let travelTheme = MemoryGameTheme<String>(name: "Travel", cardContent: ["🛫", "🚞", "🗺", "🏖", "🏜", "🌋", "🏔", "🏕", "🛣", "🌃"], colors: ["red", "blue"])
    static let weatherTheme = MemoryGameTheme<String>(name: "Weather", cardContent: ["🌈", "☀️", "⛅️", "☁️", "🌧", "🌩", "🌨", "🌙"], pairsOfCards: 8, colors: ["red", "orange", "yellow", "green", "blue", "purple"])
    static let scienceTheme = MemoryGameTheme<String>(name: "Science", cardContent: ["🧑🏾‍🔬", "🧫", "🧬", "🔬", "⚗️", "🔭", "🥼", "🧪"], pairsOfCards: nil, colors: ["blue", "green"])
    static let flagTheme = MemoryGameTheme<String>(name: "Flags", cardContent: ["🏳️‍🌈", "🏳️‍⚧️", "🇺🇳", "🇦🇷", "🇧🇩", "🇨🇳", "🇩🇰", "🇪🇬", "🇫🇷", "🇬🇭", "🇭🇰", "🇮🇪", "🇯🇵", "🇰🇪", "🇱🇦", "🇲🇽", "🇳🇿", "🇴🇲", "🇵🇷", "🇶🇦", "🇷🇼", "🇸🇾", "🇹🇭", "🇺🇸", "🇻🇳", "🇾🇪", "🇿🇲"], pairsOfCards: nil, colors: ["pink", "yellow"])
    
    static let emojiThemes = [fruitTheme, catTheme, travelTheme, weatherTheme, scienceTheme, flagTheme]
    
    static func createMemoryGame(theme: MemoryGameTheme<String>) -> MemoryGame<String> {
        let shuffledEmojiSet = Array(theme.contentSet).shuffled()
        
        return MemoryGame<String>(numberOfPairsOfCards: theme.pairsOfCards) { pairIndex in
            shuffledEmojiSet[pairIndex]
        }
    }
    
    // MARK: - Initializer
    
    init() {
        theme = EmojiMemoryGame.emojiThemes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    // MARK: - Instance Variables and Functions
    
    @Published private var model: MemoryGame<String>
    
    private var theme: MemoryGameTheme<String>
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    var themeName: String {
        return theme.themeName
    }
    
    var themeColor: LinearGradient {
        var colors = [Color]()
        
        for color in theme.themeColors {
            switch color {
            case "red":
                colors.append(.red)
            case "orange":
                colors.append(.orange)
            case "yellow":
                colors.append(.yellow)
            case "green":
                colors.append(.green)
            case "blue":
                colors.append(.blue)
            case "purple":
                colors.append(.purple)
            case "pink":
                colors.append(.pink)
            case "white":
                colors.append(.white)
            case "black":
                colors.append(.black)
            default:
                colors.append(.blue)
            }
        }
        
        return LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing)
    }
    
    var score: Double {
        return model.score
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        theme = EmojiMemoryGame.emojiThemes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
}
