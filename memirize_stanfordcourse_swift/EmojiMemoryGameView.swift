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
    //Tip:Array<String> could also be written as [Array]
    var body: some View {
        //this part run consecutively when getting asked.
        VStack{
            ScrollView{
                cards
            }.padding()
            Button("Shuffle"){
                viewModel.shuffle()
            }.font(Font.largeTitle)
        }
    }
    var cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing:0) {
            ForEach(viewModel.cards.indices, id:\.self){ index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3,contentMode: .fit)
                    .padding(4)
            }
        }.foregroundColor(Color.secondary)
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
                        .font(.system(size:200))
                        .minimumScaleFactor(0.01)
                }
                .opacity(card.isFaceUp ? 1:0)
                base.fill().opacity(card.isFaceUp ? 0:1)
            }
        }
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View{
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
