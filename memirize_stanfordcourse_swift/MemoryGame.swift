//
//  MemorizeGame.swift
//  memirize_stanfordcourse_swift
//
//  Created by 簡紹益 on 2025/3/12.
//This is the Model part of MVVM system
//Models are UI independent, which means it should not import SwiftUI
import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory:(Int) -> CardContent){
        cards = Array<Card>()
        for pairIndex in 0..<max(2,numberOfPairsOfCards){
            let content : CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
            //With the id appended, your emoji can now be identifiable!
        }
    }
    //MARK: - Intents
    //to understand how get-set and cleaner versions work
    var indexOfTheOneAndOnlyFaceUpCard: Int?{
        get{
            //cleaner version
            cards.indices.filter { index in cards[index].isFaceUp}.only
            /*##original version
            for index in cards.indices{
                if cards[index].isFaceUp{
                    faceUpCardIndices.append(index)
                }
            }
            if (faceUpCardIndices.count == 1){
                return faceUpCardIndices.first
            }
            else{
                return nil
            }*/
        }
        set{
            //cleaner version
            cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0)}
            /*original version
             for index in cards.indices{
                if index == newValue{
                    cards[index].isFaceUp = true
                }
                else{
                    cards[index].isFaceUp = false
                }
            }*/
        }
    }
    
    
    mutating func choose(_ card: Card){
        //"_" means no  external name! so you could call it by just say choose(card)
        if let chosenIndex = cards.firstIndex (where: {$0.id == card.id}){
            //"if let": Do nothing if cannot find the index of card
            //ids are all unique, so using firstIndex is fine
            if (!cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched){
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
                    if (cards[potentialMatchIndex].content == cards[chosenIndex].content){
                        cards[potentialMatchIndex].isMatched = true
                        cards[chosenIndex].isMatched = true
                    }
                }
                else{
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    /*private func index(of card: Card) -> Int?{
        for index in cards.indices{
            if( cards[index].id == card.id){
                return index
            }
        }
        return nil
    }*/
    
    mutating func shuffle(){
        //Use the shuffle() method to randomly reorder the elements of an array.
        //keep in mind you cannot mutate the model without typeing "mutating" (like a double check)
        cards.shuffle()
        print(cards)
    }
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible{
        
        var isFaceUp = false
        var isMatched = false
        let content : CardContent
        
        var id: String
        var debugDescription: String{
            "\(id): \(content) \(isFaceUp ? "up" : "down" ) \(isMatched ? "Matched" : "")"
        }
        
        /*static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
            return lhs.isFaceUp == rhs.isFaceUp
            && lhs.content == rhs.content
            && lhs.isMatched == rhs.isMatched
        }
        If all the items inside is equatable, you don't need to announce it yourself!
         */
        //lhs:left hand side; rhs: right hand side
    }
}
extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
