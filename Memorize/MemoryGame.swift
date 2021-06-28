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
    
    private var indexOfOnlyFaceUpCard: Int?
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
                indexOfOnlyFaceUpCard = nil
                timeLastCardChosen = nil
            } else {
                for index in cards.indices {
                    // Flip face up cards down, mark face up cards as seen
                    // TODO: Do I need these if checks?
                    if cards[index].isFaceUp {
                        if !cards[index].hasBeenSeen {
                            cards[index].hasBeenSeen = true
                        }
                        cards[index].isFaceUp = false
                    }
                }
                indexOfOnlyFaceUpCard = chosenIndex
                timeLastCardChosen = Date()
            }
            cards[chosenIndex].isFaceUp.toggle()
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
        cards = [Card]()
        score = 0
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var hasBeenSeen = false
        var content: CardContent
        var id: Int
    }
}
