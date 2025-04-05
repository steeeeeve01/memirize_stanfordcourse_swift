//
//  ContentView.swift
//  memirize_stanfordcourse_swift
//
//  Created by 簡紹益 on 2025/3/8.
//
//This is the View part
import SwiftUI

struct EmojiMemoryGameView: View {
    //translation:this ContentView behaves like a view
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        //this part run consecutively when getting asked.
        VStack{
            ScrollView{
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Button("Shuffle"){
                viewModel.shuffle()
            }
        }.padding()
    }
    
    private var cards: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: aspectRatio){ card in
            
            VStack{
                CardView(card)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                        
                    }
                Text(card.id)
            }
        }
        .foregroundColor(Color.secondary)
    }
}

struct CardView: View{ // every struct needs to be valued, or it's a compiler error
    let card: MemoryGame<String>.Card
    init(_ card: MemoryGame<String>.Card) {
        //the free init struct provides;"_" again means no external name ,so you could use without saying "card: something"
        self.card = card
    }
    var body: some View {
        ZStack {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            //let means it's a constant, which cannot be changed
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.largeTitle)
            }
            .opacity(card.isFaceUp ? 1:0)
            base.fill().opacity(card.isFaceUp ? 0:1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1:0)
    }
}

    
struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View{
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
