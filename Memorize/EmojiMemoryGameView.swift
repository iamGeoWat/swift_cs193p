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
            ScrollView {
                // LAZY is lazy about accessing body vars of its views
                // because creating views is light, accessing body is heavy
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    // ForEach requires element to behave like(conform) Identifiable, which needs an id, could be \.self that every element has.
                    ForEach(game.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                }
            }
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
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            // Swift will infer type
            // let for constant
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}
// View is read only, it will be constantly rebuilt when logic code changes happen. So var in View is not actual variable, only assign once.









struct ContentView_Previews: PreviewProvider {
    // this part is for generating preview window
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
    }
}


// NOTES:
// 1. SwiftUI use MVVM:
//      Model: UI Independent Data and Logic
//      View: Reflects the model, stateless, declartive, reactive
//      ViewModel: Binds View to Model, Interpreting data (from Database, Online) to what View needs
