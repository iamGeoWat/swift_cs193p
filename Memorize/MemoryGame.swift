//
//  MemoryGame.swift
//  Memorize
//
//  Created by GeoWat on 2021/12/22.
//

import Foundation

// Model

// CardContent is a generic, must specify when use this struct
struct MemoryGame<CardContent> {
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // add numberOfPairsOfCards*2 cards to cards
        for index in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(index)
            cards.append(Card(isFaceUp: false, isMatched: false, content: content))
            cards.append(Card(isFaceUp: false, isMatched: false, content: content))
        }
    }
    
    var cards: Array<Card>
    
    func choose(_ card: Card) {
        
    }
}
