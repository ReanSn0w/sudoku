//
//  GameGridView.swift
//  sudoku
//
//  Created by Дмитрий Папков on 04.05.2021.
//

import SwiftUI

struct GameGridView: View {
    @Binding var grid: GameGrid
    @Binding var selectedNumber: Int?
    @Binding var selectedGridItem: Int?
    
    init(
        _ gameGrid: Binding<GameGrid>,
        selectedNumber: Binding<Int?>,
        selectedGridItem: Binding<Int?>
    ) {
        self._grid = gameGrid
        self._selectedNumber = selectedNumber
        self._selectedGridItem = selectedGridItem
    }
    
    var body: some View {
        GeometryReader { g in
            Group{
                ForEach(0...80, id: \.self) { index in
                    GameGridItemView(
                            grid[index],
                            highlighted: grid[index] == (selectedNumber ?? 0),
                            selected: index == selectedGridItem)
                        .frame(
                            width: g.size.width / 9,
                            height: g.size.width / 9,
                            alignment: .center)
                        .offset(
                            x: CGFloat(index % 9) * g.size.width / 9,
                            y: CGFloat(index / 9) * g.size.width / 9)
                        .onTapGesture {
                            if self.selectedGridItem != index {
                                self.selectedGridItem = index
                            } else {
                                self.selectedGridItem = nil
                            }
                        }
                }
            }
        }
        .background(GameBackground(offset: 8))
        .padding()
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GameGridView(
            .constant(GridGenerator().makeGameGrid(for: .hard)),
            selectedNumber: .constant(3),
            selectedGridItem: .constant(25))
            .aspectRatio(1, contentMode: .fit)
    }
}
