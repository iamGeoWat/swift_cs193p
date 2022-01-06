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

    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly }
        set { cards.indices.forEach{cards[$0].isFaceUp = ($0 == newValue)} }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        // cards = Array<Card>() Swift can infer the type
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
                cards[chosenIndex].isFaceUp = true
            } else {
                // integrated with computed property in indexOfTheOneAndOnlyFaceUpCard
                // for index in cards.indices {
                //     cards[index].isFaceUp = false
                // }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var seen = false
        let content: CardContent
        let id: Int
    }
}

extension Array {
    // if there is only one element in array, return the element, else return nil
    var oneAndOnly: Element? { count == 1 ? first : nil }
}
