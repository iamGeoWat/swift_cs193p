//
//  Cardify.swift
//  Memorize
//
//  Created by GeoWat on 2022/1/12.
//

import SwiftUI

// This is a ViewModifier, then made into an AnimatableModifier
struct Cardify: AnimatableModifier {
    var rotation: Double
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    // required member of AnimatableModifier, telling SwiftUI what data to animate
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: CardConstants.cornerRadios)
            // Swift will infer type
            // let for constant
            if animatableData < 90 {
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: CardConstants.lineWidth)
            } else {
                shape.fill()
            }
            // Why take emoji out if-else and give opacity? To make animation work on the latter opened card:
            // Two Rules of Animation:
            // 1. Animation only animate changes, in this case, isMatched changed, not a problem with rule 1
            // 2. Animation only works on contents already on screen. Because isFaceUp and isMatched are set to true at the same time, if emoji is in if-else, it renders when isMatched already is true. So animation will fail.
            content
                .opacity(animatableData < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(animatableData), axis: (0, 1, 0))
    }
    
    private struct CardConstants {
        static let cornerRadios: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
}

// use extension to simplify code
// Circle().modifier(Cardify()) -> Circle().cardify()
extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
