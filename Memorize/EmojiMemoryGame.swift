//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by GeoWat on 2021/12/22.
//

import SwiftUI

// ViewModel should be a class, for sharing within View components
let emojiLibrary = ["animals": ["🐒", "🐯", "🐭", "🐷", "🐶", "🐱", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🦁", "🐮", "🐸", "🐔", "🐧", "🐦", "🐤", "🦆", "🐝", "🦄"], "vehicles": ["🏍", "🛺", "🚔", "🚍", "🚘", "🚖", "🚡", "🚃", "🚄", "🚂", "✈️", "🚀", "🛸", "⛵️", "🚁", "🛳", "🛰"], "foods": ["🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🥭", "🍟", "🫓", "🥙", "🍲", "🍱", "🥗", "🥠", "🍢", "🍙", "🍭"]]



class EmojiMemoryGame {
    // static make it namespaced global constant(Type Property). Also good for func(Type Function). Thus can be accessed in property initializers.
    static let emojis = ["🐒", "🐯", "🐭", "🐷", "🐶", "🐱", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🦁", "🐮", "🐸"].shuffled()
    
    // use private to control access. (set) means Read-only, or provide getter
    private(set) var model: MemoryGame<String>
    
    init() {
        model = MemoryGame<String>(numberOfPairsOfCards: 4) { index in EmojiMemoryGame.emojis[index] }
    }
    
}
