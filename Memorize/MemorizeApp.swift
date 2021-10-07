//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Ryan Zubery on 6/1/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
