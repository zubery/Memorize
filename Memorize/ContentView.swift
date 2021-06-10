//
//  ContentView.swift
//  Memorize
//
//  Created by Ryan Zubery on 6/1/21.
//

import SwiftUI

struct ContentView: View {
    @State var emojis = ["3️⃣", "2️⃣", "1️⃣", "😦"]
    @State var emojiCount = 4
    
    let fruitEmojis = ["🍏", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝"]
    let weatherEmojis = ["🌈", "☀️", "⛅️", "☁️", "🌧", "🌩", "🌨", "🌙"]
    let flagEmojis = ["🏳️‍🌈", "🏳️‍⚧️", "🇺🇳", "🇦🇷", "🇧🇩", "🇨🇳", "🇩🇰", "🇪🇬", "🇫🇷", "🇬🇭", "🇭🇰", "🇮🇪", "🇯🇵", "🇰🇪", "🇱🇦", "🇲🇽", "🇳🇿", "🇴🇲", "🇵🇷", "🇶🇦", "🇷🇼", "🇸🇾", "🇹🇭", "🇺🇸", "🇻🇳", "🇾🇪", "🇿🇲"]
    
    var body: some View {
        VStack {
            Text("Memorize").font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(13/21, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.green)
            Spacer()
            HStack(alignment: .bottom) {
                fruitTheme
                Spacer()
                weatherTheme
                Spacer()
                flagTheme
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding()
    }
    
    var fruitTheme: some View {
        Button {
            emojis = fruitEmojis.shuffled()
            emojiCount = Int.random(in: 4..<fruitEmojis.count)
        } label: {
            VStack {
                Image(systemName: "leaf").font(.largeTitle)
                Text("Fruit").font(.headline)
            }
        }
    }
    var weatherTheme: some View {
        Button {
            emojis = weatherEmojis.shuffled()
            emojiCount = Int.random(in: 4..<weatherEmojis.count)
        } label: {
            VStack {
                Image(systemName: "cloud.sun").font(.largeTitle)
                Text("Weather").font(.headline)
            }
            
        }
    }
    var flagTheme: some View {
        Button {
            emojis = flagEmojis.shuffled()
            emojiCount = Int.random(in: 4..<flagEmojis.count)
        } label: {
            VStack {
                Image(systemName: "flag").font(.largeTitle)
                Text("Flags").font(.headline)
            }
        }
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25.0)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
