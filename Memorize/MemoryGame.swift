//
//  MemoryGame.swift
//  Memorize
//
//  Created by Ryan Zubery on 6/19/21.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private(set) var score: Double
    
    private var indexOfOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    private(set) var timeLastCardChosen: Date?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    // Match
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    award()
                } else {
                    // Not a match
                    if cards[chosenIndex].hasBeenSeen {
                        penalty()
                    }
                    if cards[potentialMatchIndex].hasBeenSeen {
                        penalty()
                    }
                }
                cards[chosenIndex].isFaceUp = true
                timeLastCardChosen = nil
            } else {
                cards.indices.forEach { cards[$0].hasBeenSeen = cards[$0].isFaceUp ? true : cards[$0].hasBeenSeen }
                indexOfOnlyFaceUpCard = chosenIndex
                timeLastCardChosen = Date()
            }
        }
    }
    
    // TODO: Are below methods too similar?
    private mutating func award() {
        let base = 200.0
        let secondsTaken = abs(timeLastCardChosen!.timeIntervalSinceNow)
        let timePenalty = pow(min(10.0, secondsTaken), 2)
        
        score += (base - timePenalty)
    }
    
    private mutating func penalty() {
        let secondsTaken = abs(timeLastCardChosen!.timeIntervalSinceNow)
        let timePenalty = pow(min(10.0, secondsTaken), 2)
        
        score -= timePenalty
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        score = 0
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        
        cards.shuffle()
    }
    
    // TODO: Are you using type inference everywhere?
    struct Card: Identifiable {
        var isFaceUp = true
        var isMatched = false
        var hasBeenSeen = false
        let content: CardContent
        let id: Int
    }
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
