//
//  NewGameMenuScene.swift
//  sudoku
//
//  Created by Дмитрий Папков on 05.05.2021.
//

import SwiftUI

struct NewGameMenuScene: View {
    @State var game: GameModel? = nil
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 16) {
            HStack { Spacer() }
            
            Spacer()
            
            ButtonMenuItemView("Простой") { self.game = .init(with: .flash) }
            ButtonMenuItemView("Легкий") { self.game = .init(with: .easy) }
            ButtonMenuItemView("Средний") { self.game = .init(with: .medium) }
            ButtonMenuItemView("Сложний") { self.game = .init(with: .hard) }
            ButtonMenuItemView("Невообразимый") { self.game = .init(with: .insane) }
        }
        .padding()
        .navigationBarTitle(Text("Новая игра"), displayMode: .large)
        .fullScreenCover(item: $game) { GameScene(model: $0) }
    }
}

struct NewGameMenuScene_Previews: PreviewProvider {
    static var previews: some View {
        NewGameMenuScene()
    }
}
