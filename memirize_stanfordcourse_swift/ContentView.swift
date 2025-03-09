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
    var isFaceUp: Bool = false
    var body: some View {
        ZStack {
            if isFaceUp{
                RoundedRectangle(cornerRadius:12)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius:12)
                    .strokeBorder(style: StrokeStyle(lineWidth:2))
                Text("HelloPiyan")
                    .font(.largeTitle)
            }
            else{
                RoundedRectangle(cornerRadius:12)
            }
        }
    }
}
#Preview {
    ContentView()
}
