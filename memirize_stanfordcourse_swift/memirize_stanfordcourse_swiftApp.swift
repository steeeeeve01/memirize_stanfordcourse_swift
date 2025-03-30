//
//  memirize_stanfordcourse_swiftApp.swift
//  memirize_stanfordcourse_swift
//
//  Created by 簡紹益 on 2025/3/8.
//

import SwiftUI

@main
struct memirize_stanfordcourse_swiftApp: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
