//
//  MemoryGame.swift
//  Memorize
//
//  Created by GeoWat on 2021/12/22.
//

import Foundation

// Model

// CardContent is a generic, must specify when use this struct
struct MemoryGame<CardContent> where CardContent: Equatable {

    var cards: Array<Card>
    
    var score: Int = 0

    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // add numberOfPairsOfCards*2 cards to cards
        for index in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(index)
            cards.append(Card(content: content, id: index * 2))
            cards.append(Card(content: content, id: index * 2 + 1))
        }
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        // Game logic here:
        // When use if let, use comma to seperate conditions
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched {
            if let lastChosen = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[lastChosen].content {
                    // matched
                    cards[chosenIndex].isMatched = true
                    cards[lastChosen].isMatched = true
                    score += 2
                } else if cards[lastChosen].seen || cards[chosenIndex].seen {
                    // not matched and seen at least one of them before, loose score
                    score -= (cards[lastChosen].seen ? 1 : 0) + (cards[chosenIndex].seen ? 1 : 0)
                }
                cards[lastChosen].seen = true
                cards[chosenIndex].seen = true
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var seen: Bool = false
        var content: CardContent
        var id: Int
    }
}
