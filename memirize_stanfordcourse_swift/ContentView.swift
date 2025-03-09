//
//  ContentView.swift
//  memirize_stanfordcourse_swift
//
//  Created by 簡紹益 on 2025/3/8.
//

import SwiftUI

struct ContentView: View {
    //this ContentView behaves like a view
    let emojis: Array<String> = ["👻","😘","😈","🫥","🙄"]
    //Array<String> could also be written as [Array]
    @State var cardCount: Int = 4
    var body: some View {
        //run consecutively when getting asked.
        VStack{
            ScrollView{
                cards
            }
            cardCountAdjusters
            
        }.padding()
    }
    var cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id:\.self){ index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3,contentMode: .fit)
            }
        }.foregroundColor(.pink)
    }
    var cardCountAdjusters: some View{
        HStack{
            cardAdder
            Spacer()
            cardRemover
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View{
        Button(action:{
            cardCount += offset
        }, label:{
            Image(systemName: symbol)
        }).disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    var cardAdder: some View{
            cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
    var cardRemover: some View{
            cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
}
struct CardView: View{
    let content: String
    @State var isFaceUp: Bool = false // default state
    // every struct needs to be valued
    
    var body: some View {
        ZStack {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            //let means it's a constant
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content)
                    .font(.largeTitle)
            }
            .opacity(isFaceUp ? 1:0)
            base.fill().opacity(isFaceUp ? 0:1)
        }
        .onTapGesture{
            isFaceUp.toggle()
        }
    }
}
#Preview {
    ContentView()
}
