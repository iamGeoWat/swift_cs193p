//
//  Theme.swift
//  Memorize
//
//  Created by GeoWat on 2022/1/4.
//

import Foundation

// Model for theme

struct Theme {
    static let emojiLibrary = [
        "Animals": ["🐒", "🐯", "🐭", "🐷", "🐶", "🐧", "🐦", "🐤", "🦆", "🐝", "🦄"],
        "Vehicles": ["🏍", "🛺", "🚔", "🚍", "🚘", "🚖", "🚡", "🚃", "🚄", "🚂", "✈️", "🚀", "🛸", "⛵️", "🚁", "🛳", "🛰"],
        "Foods": ["🍌", "🥗", "🍙", "🍭"],
        "Instruments": ["🎹", "🎮", "🎰", "🎻", "🎺"],
        "Flags": ["🇧🇧", "🏳️‍⚧️", "🇧🇪", "🇦🇫", "🇧🇭", "🇧🇹", "🇺🇳"],
        "Clothes": ["🥻", "👚", "🥾", "🩲", "👢", "🧣"]
    ]
    
    static let colors = ["Purple", "Green", "Red", "Yellow", "Cyan", "What", "Pink", "Grey"]
    
    var emojis: Array<String> = emojiLibrary["Animals"]!.shuffled()

    var name: String = "Animals"
    
    var numberOfPairsOfCardsToShow: Int = 6
    
    var color: String = "Purple"
    
    mutating func chooseTheme(_ name: String) {
        if let newEmojis = Theme.emojiLibrary[name] {
            if newEmojis.count < numberOfPairsOfCardsToShow {
                numberOfPairsOfCardsToShow = newEmojis.count
            }
            emojis = newEmojis.shuffled()
            self.name = name
        }
    }
    
    init() {
        // randomly create a theme
        name = Theme.emojiLibrary.keys.randomElement()!
        color = Theme.colors.randomElement()!
        chooseTheme(name)
    }
    
    init(name: String, numberOfPairOfCardsToShow: Int, color: String) {
        self.name = name
        self.numberOfPairsOfCardsToShow = numberOfPairOfCardsToShow
        self.color = color
        chooseTheme(name)
    }
    
}
