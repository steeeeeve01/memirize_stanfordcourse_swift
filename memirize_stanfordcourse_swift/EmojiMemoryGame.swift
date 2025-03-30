//
//  EmojiMemoryGame.swift
//  memirize_stanfordcourse_swift
//
//  Created by 簡紹益 on 2025/3/12.
//
//this is the ViewModel part in MVVM system
import SwiftUI
// View Model is part of the UI
class EmojiMemoryGame: ObservableObject {
    static let emojis = ["👻","😘","😈","🫥","👩🏾‍🦳","👻","😘","😈","🫥","👩🏾‍🦳"]

    @Published private var model = createMemoryGame()
    //"@Published" informs when it's "gonna" change; primary way to announce the change
    private static func createMemoryGame() ->  MemoryGame<String>{
        MemoryGame(numberOfPairsOfCards:10){ pairIndex in
            if emojis.indices.contains(pairIndex){
                //to examine if the given index points to a emoji
                return emojis[pairIndex]
            }
            else{
                return("⁉️")
            }
        }
    }
    //MARK: - Intents
    func shuffle(){
        model.shuffle()
    }
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    func choose (_ card: MemoryGame<String>.Card){ //to present user's intent, that's part of the ViewModel's role
        model.choose(card)
    }
}
