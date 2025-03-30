//
//  MemorizeGame.swift
//  memirize_stanfordcourse_swift
//
//  Created by 簡紹益 on 2025/3/12.
//This is the Model part of MVVM system
//Models are UI independent, which means it should not import SwiftUI
import Foundation

struct MemoryGame<CardContent>{
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory:(Int) -> CardContent){
        cards = Array<Card>()
        for pairIndex in 0..<max(2,numberOfPairsOfCards){
            let content : CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card){
        //"_" means no external name! so you could call it by just say choose(card)
    }
    
    mutating func shuffle(){
        //Use the shuffle() method to randomly reorder the elements of an array.
        //keep in mind you cannnot mutate the model without typeing "mutating" (like a double check)
        cards.shuffle()
        print(cards)
    }
    struct Card{
        var isFaceUp = true
        var isMatched = false
        let content : CardContent
    }
}
