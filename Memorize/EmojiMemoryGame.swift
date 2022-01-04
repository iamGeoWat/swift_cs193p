//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by GeoWat on 2021/12/22.
//

import SwiftUI

// ViewModel should be a class, for sharing within View components
// KEY OF MVVM: ObervableObject and @Published
class EmojiMemoryGame: ObservableObject {
    // static make it namespaced global constant(Type Property). Also good for func(Type Function). Thus can be accessed in property initializers.
    private var theme: Theme
    
    // use private to control access. (set) means Read-only, if not use (set), provide getter
    // private(set) var model: MemoryGame<String>
    @Published private var model: MemoryGame<String>
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    static func createMemoryGame(_ theme: Theme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairOfCardsToShow) { index in theme.emojis[index] }
    }
    
    func getThemeName() -> String {
        return theme.name
    }
    
    // color interpreter
    func getColor() -> Color {
        switch theme.color {
        case "Purple":
            return Color.purple
        case "Green":
            return Color.green
        case "Red":
            return Color.red
        case "Yellow":
            return Color.yellow
        case "Cyan":
            return Color.cyan
        case "Pink":
            return Color.pink
        case "Grey":
            return Color.gray
        default:
            return Color.purple
        }
    }
    
    init() {
        theme = Theme()
        model = EmojiMemoryGame.createMemoryGame(theme)
    }
    
    // MARK: - Intents
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func getScore() -> String {
        return String(model.score)
    }
    
    // randomly change theme
    func refreshMemoryGame() {
        theme = Theme()
        model = EmojiMemoryGame.createMemoryGame(theme)
    }
    
}
