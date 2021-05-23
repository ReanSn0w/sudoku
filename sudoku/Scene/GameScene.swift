//
//  GameScene.swift
//  sudoku
//
//  Created by Дмитрий Папков on 05.05.2021.
//

import SwiftUI

struct GameScene: View {
    @Environment(\.presentationMode) var presentation
    
    @ObservedObject var model: GameModel
    
    init(model: GameModel) {
        self.model = model
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("Счет: ")
                    +
                    Text("\(model.score)").font(.headline)
                
                Text("Время: ")
                    +
                    Text("00:00:00").font(.headline)
            }
            .padding(.horizontal)
            
            Spacer()
            
//            GameGridView(
//                model.gameGrid,
//                selectedNumber: $model.selectedNumber,
//                selectedGridItem: $model.selectedGridItem)
//                .aspectRatio(1, contentMode: .fit)
            
            GameGridView(
                grid: model.bindingGrid,
                highlightedPoints: model.highlightedPoints,
                errorPoints: $model.wrongPoints,
                selectedPoint: model.selectedPoint) { point in
                self.model.selectedPoint.wrappedValue = point
            }
            .aspectRatio(1, contentMode: .fit)
            
            Spacer()
            
            AvaliableNumbersView(
                avaliableNumbers: model.avaliableNumbers,
                selectedNumber: $model.selectedNumber)
                { self.model.doStep() }
                .aspectRatio(9, contentMode: .fit)
            
            Spacer()
        }
        .overlay(exitButton, alignment: .topTrailing)
        .alert(isPresented: model.gameEnded, content: {
            Alert(title: Text("Поздравляем!"),
                  message: Text("Игра успешно завершена"),
                  dismissButton: .default(
                    Text("Готово"),
                    action: { self.presentation.wrappedValue.dismiss() }))
        })
    }
    
    var exitButton: some View {
        Button(action: { self.presentation.wrappedValue.dismiss() }) {
            Image(systemName: "xmark.circle.fill")
                .font(.title2)
        }
        .padding()
    }
}

struct GameScene_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameScene(model: GameModel(.insane))
        }
    }
}
