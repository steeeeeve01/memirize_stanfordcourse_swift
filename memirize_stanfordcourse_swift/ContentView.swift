//
//  ContentView.swift
//  memirize_stanfordcourse_swift
//
//  Created by 簡紹益 on 2025/3/8.
//

import SwiftUI

struct ContentView: View {
    //this ContentView behaves like a view
    @State var emojis: Array<String> = ["👻","😘","😈","🫥","👩🏾‍🦳","👻","😘","😈","🫥","👩🏾‍🦳"]
    let theme1: Array<String> = ["👻","😘","😈","🫥","👩🏾‍🦳","👻","😘","😈","🫥","👩🏾‍🦳"]
    let theme2: Array<String> = ["⚽️","🏀","🏈","⚾️","🏐","⚽️","🏀","🏈","⚾️","🏐"]
    let theme3: Array<String> = ["🍇","🍈","🍉","🍊","🍋","🍋‍🟩","🍌","🍍","🥭","🍎"]
    @State var themechoose: Int = 1
    //Array<String> could also be written as [Array]
    @State var cardCount: Int = 4
    var body: some View {
        //run consecutively when getting asked.
        VStack{
            Title
            themeAdjusters
            ScrollView{
                cards
            }
            cardCountAdjusters
            
        }.padding()
    }
    var Title: some View{
        Text("Memorize!")
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
    
    var themeAdjusters: some View{
        HStack{
            themer1
            Spacer()
            themer2
            Spacer()
            themer3
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    func themeAdjuster(by themer:Int,symbol:String)-> some View{
        Button(action:{
            if (themer == 1){
                emojis = theme1
            }
            else if (themer == 2){
                emojis = theme2
            }
            else{
                emojis = theme3
            }
        },label:{
            Image(systemName: symbol)
        })
    }
    var themer1: some View{
        themeAdjuster(by:1, symbol:"1.lane")
    }
    var themer2: some View{
        themeAdjuster(by:2, symbol:"2.lane")
    }
    var themer3: some View{
        themeAdjuster(by:3, symbol:"3.lane")
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
        }).disabled(cardCount + offset < 4 || cardCount + offset > emojis.count)
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
