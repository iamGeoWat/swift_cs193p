//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by GeoWat on 2021/12/14.
//

// SwiftUI uses functional programming
import SwiftUI

struct EmojiMemoryGameView: View {    
    // KEY OF MVVM: @ObservedObject
    @ObservedObject var game: EmojiMemoryGame // This is the ViewModel, ViewModel is created and injected in App.swift
    
    // function return will replace SOME after excuted
    var body: some View {
        VStack {
            Text("Memorize \(game.getThemeName())!").font(.largeTitle)
            Text("Your Score: \(game.getScore())").font(.title)
            AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
                // this if-else is a ViewBuilder
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            })
            .foregroundColor(game.getColor())
            Spacer()
            HStack {
                newGame
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    var newGame: some View {
        Button {
            game.refreshMemoryGame()
        } label: {
            VStack {
                Image(systemName: "arrow.clockwise.circle")
                    .font(.title)
                    .frame(width: 30, height: 30)
                Text("New Game").font(.footnote)
            }
        }
    }
}

struct CardView: View {
    let card: EmojiMemoryGame.Card
    // Option + Click to pop up documents
    
    // @State var isFaceUp: Bool = false
    // @State: temporary state(middle of drag), not used often
    // @State will make variable become a pointer to memory which stores the actual variable
    
    var body: some View {
        // Use GeometryReader to fit emojis in cards automatically
        GeometryReader { geometry in
            ZStack {
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                    .padding(5)
                    .opacity(0.5)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                    .font(font(in: geometry.size))
            }
            // implemented cardify ViewModifier to simplify this
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    // to clean up code
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * CardConstants.fontScale)
    }
    
    // to gather magic numbers
    private struct CardConstants {
        static let fontScale: CGFloat = 0.7
    }
}
// View is read only, it will be constantly rebuilt when logic code changes happen. So var in View is not actual variable, only assign once.









struct ContentView_Previews: PreviewProvider {
    // this part is for generating preview window
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game).preferredColorScheme(.dark)
    }
}


// NOTES:
// 1. SwiftUI use MVVM:
//      Model: UI Independent Data and Logic
//      View: Reflects the model, stateless, declartive, reactive
//      ViewModel: Binds View to Model, Interpreting data (from Database, Online) to what View needs
