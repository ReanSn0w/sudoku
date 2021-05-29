//
//  MainMenuScene.swift
//  sudoku
//
//  Created by Дмитрий Папков on 05.05.2021.
//

import SwiftUI

struct MainMenuScene: View {
    @EnvironmentObject var gc: GameCenter
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 16) {
            HStack { Spacer() }
            
            Spacer()
            
            NavigationMenuItemView("Новая игра") {
                NewGameMenuScene()
            }
            
            if !gc.scores.isEmpty {
                NavigationMenuItemView("Результаты") {
                    ScoresScene()
                }
            }
            
            NavigationMenuItemView("Правила") {
                RulesScene()
            }
            
            Link("Исходный код",
                 destination: URL(
                    string: "https://github.com/ReanSn0w/sudoku"
                 )!
            )
        }
        .padding()
        .navigationBarTitle(Text("Sudoku"), displayMode: .large)
    }
}

struct MainMenuScene_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainMenuScene()
        }
    }
}


