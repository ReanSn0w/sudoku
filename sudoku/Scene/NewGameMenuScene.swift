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
            
            ButtonMenuItemView("Простой") { self.game = .init(.flash) }
            ButtonMenuItemView("Легкий") { self.game = .init(.easy) }
            ButtonMenuItemView("Средний") { self.game = .init(.medium) }
            ButtonMenuItemView("Сложний") { self.game = .init(.hard) }
            ButtonMenuItemView("Невообразимый") { self.game = .init(.insane) }
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
