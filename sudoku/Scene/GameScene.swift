//
//  GameScene.swift
//  sudoku
//
//  Created by Дмитрий Папков on 05.05.2021.
//

import SwiftUI

class GameModel: ObservableObject, Identifiable {
    @Published private var userDefined: GameGrid
    private let grid: Grid
    private let defaultGameGrid: GameGrid
    
    @Published var selectedNumber: Int? = nil
    @Published var selectedGridItem: Int? = nil
    
    var gameEnded: Binding<Bool> {
        .init(get: {
            for index in 0...80 {
                if self.grid[index] != self.userDefined[index] {
                    return false
                }
            }
            
            return true
        }, set: { _ in })
    }
    
    var gameGrid: Binding<GameGrid> {
        .init {
            self.userDefined
        } set: { newValue in
            for index in 0...80 {
                guard let val = self.defaultGameGrid[index] else {
                    continue
                }
                
                if self.userDefined[index] != val {
                    return
                }
            }
            
            self.userDefined = newValue
        }
    }
    
    var selectedGridItemEditable: Bool {
        guard let index = selectedGridItem else {
            return false
        }
        
        return defaultGameGrid[index] == nil
    }
    
    var avaliableNumbers: Set<Int> {
        var avaliable: [Int:Int] = [:]
        
        userDefined.forEach { val in
            guard let val = val else { return }
            if avaliable[val] != nil {
                avaliable[val]! += 1
            } else {
                avaliable[val] = 1
            }
        }
        
        return Set(avaliable.compactMap { key, value in
            if value == 9 {
                return nil
            }
            
            return key
        })
    }
    
    init(with difficulty: GridGenerator.Difficulty) {
        let generator = GridGenerator()
        
        self.grid = generator.grid
        self.defaultGameGrid = generator.makeGameGrid(for: difficulty)
        self.userDefined = self.defaultGameGrid
    }
    
}

struct GameScene: View {
    @Environment(\.presentationMode) var presentation
    
    @ObservedObject var model: GameModel
    
    init(model: GameModel) {
        self.model = model
    }
    
    var selectedNumberProxy: Binding<Int?> {
        .init {
            self.model.selectedNumber
        } set: { newNumber in
            if self.model.selectedGridItemEditable,
               let index = self.model.selectedGridItem,
               let newNumber = newNumber {
                
                if self.model.gameGrid.wrappedValue[index] == newNumber && !self.model.avaliableNumbers.contains(newNumber) {
                    self.model.gameGrid.wrappedValue[index] = nil
                } else {
                    self.model.gameGrid.wrappedValue[index] = newNumber
                }
                
                self.model.selectedGridItem = nil
            }
            
            self.model.selectedNumber = newNumber
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            GameGridView(
                model.gameGrid,
                selectedNumber: $model.selectedNumber,
                selectedGridItem: $model.selectedGridItem)
                .aspectRatio(1, contentMode: .fit)
            
            Spacer()
            
            AvaliableNumbersView(
                avaliableNumbers: model.avaliableNumbers,
                selectedNumber: selectedNumberProxy)
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
        GameScene(model: GameModel(with: .insane))
    }
}
