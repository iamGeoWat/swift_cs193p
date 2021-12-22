//
//  ContentView.swift
//  Memorize
//
//  Created by GeoWat on 2021/12/14.
//

// SwiftUI uses functional programming
import SwiftUI

struct ContentView: View {
    let emojiLibrary = ["animals": ["🐒", "🐯", "🐭", "🐷", "🐶", "🐱", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🦁", "🐮", "🐸", "🐔", "🐧", "🐦", "🐤", "🦆", "🐝", "🦄"], "vehicles": ["🏍", "🛺", "🚔", "🚍", "🚘", "🚖", "🚡", "🚃", "🚄", "🚂", "✈️", "🚀", "🛸", "⛵️", "🚁", "🛳", "🛰"], "foods": ["🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🥭", "🍟", "🫓", "🥙", "🍲", "🍱", "🥗", "🥠", "🍢", "🍙", "🍭"]]
    @State var emojis = ["🐒", "🐯", "🐭", "🐷", "🐶", "🐱", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🦁", "🐮", "🐸"].shuffled()
    @State var emojiCount = 8
    // function return will replace SOME after excuted
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                // LAZY is lazy about accessing body vars of its views
                // because creating views is light, accessing body is heavy
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    // ForEach requires element to behave like(conform) Identifiable, which needs an id, could be \.self that every element has.
                    ForEach(emojis[0..<emojiCount], id: \.self, content: {
                        emoji in CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    })
                }
            }
            .foregroundColor(.purple)
            Spacer()
            HStack {
                add
                Spacer()
                themeAnimals
                Spacer()
                themeFoods
                Spacer()
                themeVehicles
                Spacer()
                remove
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    var themeAnimals: some View {
        Button {
            emojis = emojiLibrary["animals"]!
            emojiCount = 8
            emojis.shuffle()
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
            emojis = emojiLibrary["vehicles"]!
            emojiCount = 8
            emojis.shuffle()
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
        Button {
            emojis = emojiLibrary["foods"]!
            emojiCount = 8
            emojis.shuffle()
        } label: {
            VStack {
                Image(systemName: "takeoutbag.and.cup.and.straw")
                    .font(.title)
                    .frame(width: 30, height: 30)
                Text("Foods").font(.footnote)
            }
        }
    }
    var add: some View {
        // both of them are functions, then can get rid of the keyword, and get out of the parentheses
        Button {
            if emojiCount < emojis.count { emojiCount += 1 }
        } label: {
            VStack {
                // using https://www.developer.apple.com/sf-symbols
                Image(systemName: "plus.circle")
            }
        }
    }
    var remove: some View {
        Button(action: {
            if emojiCount > 1 { emojiCount -= 1 }
        }, label: {
            VStack {
                Image(systemName: "minus.circle")
            }
        })
    }
}

struct CardView: View {
    var content: String
    // Option + Click to pop up documents
    @State var isFaceUp: Bool = false
    // @State: temporary state(middle of drag), not used often
    // @State will make variable become a pointer to memory which stores the actual variable
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            // Swift will infer type
            // let for constant
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}
// View is read only, it will be constantly rebuilt when logic code changes happen. So var in View is not actual variable, only assign once.









struct ContentView_Previews: PreviewProvider {
    // this part is for generating preview window
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
