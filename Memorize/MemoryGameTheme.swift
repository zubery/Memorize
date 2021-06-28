//
//  MemoryGameTheme.swift
//  Memorize
//
//  Created by Ryan Zubery on 6/21/21.
//

import Foundation

struct MemoryGameTheme<CardContent> where CardContent: Hashable {
    let themeName: String
    let contentSet: Set<CardContent>
    private(set) var pairsOfCards: Int
    let themeColors: [String]
    
    init(name themeName: String, cardContent contentSet: Set<CardContent>, colors themeColors: [String]) {
        self.themeName = themeName
        self.contentSet = contentSet
        // TODO: Refactor to not assume contentSet will always be 2+ size
        self.pairsOfCards = Int.random(in: 2..<self.contentSet.count)
        self.themeColors = themeColors
    }

    init(name themeName: String, cardContent contentSet: Set<CardContent>, pairsOfCards: Int?, colors themeColors: [String]) {
        self.themeName = themeName
        self.contentSet = contentSet
        // TODO: Refactor to not assume contentSet will always be 2+ size
        if let unwrappedPairsOfCards = pairsOfCards {
            self.pairsOfCards = unwrappedPairsOfCards > 1
                ? min(unwrappedPairsOfCards, self.contentSet.count)
                : Int.random(in: 2..<self.contentSet.count)
        } else {
            self.pairsOfCards = self.contentSet.count
        }
        self.themeColors = themeColors
    }
}
