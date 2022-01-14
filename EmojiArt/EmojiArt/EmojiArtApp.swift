//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by GeoWat on 2022/1/14.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    let document = EmojiArtDocument()
    
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: document)
        }
    }
}
