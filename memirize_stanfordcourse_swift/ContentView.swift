//
//  ContentView.swift
//  memirize_stanfordcourse_swift
//
//  Created by 簡紹益 on 2025/3/8.
//

import SwiftUI

struct ContentView: View {
    //this ContentView behaves like a view
    var body: some View {
        //run consecutively when getting asked.
        HStack {
            CardView(isFaceUp: true)
            CardView()
            CardView()
            CardView()
        }
            .foregroundColor(.pink)
            .padding()
    }
}
struct CardView: View{
    @State var isFaceUp: Bool = false // default state
    // every struct needs to be valued
    
    var body: some View {
        ZStack {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            //let means it's a constant
            if isFaceUp{
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text("HelloPiyan")
                    .font(.largeTitle)
            }
            else{
                base.fill()
            }
        }
        .onTapGesture{
            isFaceUp.toggle()
        }
    }
}
#Preview {
    ContentView()
}
