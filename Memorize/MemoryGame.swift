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

    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // add numberOfPairsOfCards*2 cards to cards
        for index in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(index)
            cards.append(Card(content: content, id: index * 2))
            cards.append(Card(content: content, id: index * 2 + 1))
        }
    }
    
    mutating func choose(_ card: Card) {
        // Game logic here:
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           // When use if let, use comma to seperate conditions
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched {
            if let lastChosen = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[lastChosen].content {
                    cards[chosenIndex].isMatched = true
                    cards[lastChosen].isMatched = true
                }
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
        var content: CardContent
        var id: Int
    }
}
