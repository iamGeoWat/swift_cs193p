//
//  ContentView.swift
//  Memorize
//
//  Created by GeoWat on 2021/12/14.
//

// SwiftUI uses functional programming
import SwiftUI

struct ContentView: View {
    // KEY OF MVVM: @ObservedObject
    @ObservedObject var game: EmojiMemoryGame // This is the ViewModel, ViewModel is created and injected in App.swift
    
    // function return will replace SOME after excuted
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
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
            .foregroundColor(.purple)
            Spacer()
            HStack {
                themeAnimals
                Spacer()
                themeFoods
                Spacer()
                themeVehicles
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    var themeAnimals: some View {
        Button {
            game.changeTheme(to: "animals")
        } label: {
            VStack {
                Image(systemName: "pawprint")
                    .font(.title)
                    .frame(width: 30, height: 30)
                Text("Animals").font(.footnote)
            }
        }
    }
    var themeVehicles: some View {
        Button {
            game.changeTheme(to: "animals")
        } label: {
            VStack() {
                Image(systemName: "car.2")
                    .font(.title)
                    .frame(width: 30, height: 30)
                Text("Vehicles").font(.footnote)
            }
        }
    }
    var themeFoods: some View {
        // both of them are functions, then can get rid of the keyword, and get out of the parentheses
        Button {
            game.changeTheme(to: "animals")
        } label: {
            VStack {
                Image(systemName: "takeoutbag.and.cup.and.straw")
                    .font(.title)
                    .frame(width: 30, height: 30)
                Text("Foods").font(.footnote)
            }
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
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
        ContentView(game: game)
            .preferredColorScheme(.dark)
        ContentView(game: game)
            .preferredColorScheme(.light)
    }
}


// NOTES:
// 1. SwiftUI use MVVM:
//      Model: UI Independent Data and Logic
//      View: Reflects the model, stateless, declartive, reactive
//      ViewModel: Binds View to Model, Interpreting data (from Database, Online) to what View needs
