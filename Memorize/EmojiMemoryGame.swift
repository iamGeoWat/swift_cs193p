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
    static var emojis = ["🐒", "🐯", "🐭", "🐷", "🐶", "🐱", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🦁", "🐮", "🐸"].shuffled()
    static let emojiLibrary = ["animals": ["🐒", "🐯", "🐭", "🐷", "🐶", "🐱", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🦁", "🐮", "🐸", "🐔", "🐧", "🐦", "🐤", "🦆", "🐝", "🦄"], "vehicles": ["🏍", "🛺", "🚔", "🚍", "🚘", "🚖", "🚡", "🚃", "🚄", "🚂", "✈️", "🚀", "🛸", "⛵️", "🚁", "🛳", "🛰"], "foods": ["🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🥭", "🍟", "🫓", "🥙", "🍲", "🍱", "🥗", "🥠", "🍢", "🍙", "🍭"]]
    
    // use private to control access. (set) means Read-only, if not use (set), provide getter
    // private(set) var model: MemoryGame<String>
    @Published private var model: MemoryGame<String>
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func changeTheme(to theme: String) {
        EmojiMemoryGame.emojis = EmojiMemoryGame.emojiLibrary[theme]!
        EmojiMemoryGame.emojis.shuffle()
    }
    
    init() {
        model = MemoryGame<String>(numberOfPairsOfCards: 4) { index in EmojiMemoryGame.emojis[index] }
    }
    
    // MARK: - Intents
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
}
