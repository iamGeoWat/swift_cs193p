//
//  MemorizeApp.swift
//  Memorize
//
//  Created by GeoWat on 2021/12/14.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame() // This is the ViewModel
    
    var body: some Scene {
        WindowGroup {
            ContentView(game: game)
        }
    }
}
