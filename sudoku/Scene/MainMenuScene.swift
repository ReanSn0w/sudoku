//
//  MainMenuScene.swift
//  sudoku
//
//  Created by Дмитрий Папков on 05.05.2021.
//

import SwiftUI

struct MainMenuScene: View {
    var body: some View {
        VStack(alignment: .trailing, spacing: 16) {
            HStack { Spacer() }
            
            Spacer()
            
            NavigationMenuItemView("Новая игра") {
                NewGameMenuScene()
            }
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


