//
//  GameGridView.swift
//  sudoku
//
//  Created by Дмитрий Папков on 22.05.2021.
//

import SwiftUI

struct GameGridView: View {
    @Binding var grid: GameGrid
    @Binding var highlightedPoints: [Point]
    @Binding var errorPoints: [Point]
    @Binding var selectedPoint: Point?
    
    var tap: (Point) -> Void
    
    var body: some View {
        GeometryReader { g in
            Group{
                ForEach(0...80, id: \.self) { index in
                    GameGridItemView(
                            grid[index],
                            highlight: highlightForIndex(index),
                            selected: selectedForIndex(index))
                        .frame(
                            width: g.size.width / 9,
                            height: g.size.width / 9,
                            alignment: .center)
                        .offset(
                            x: CGFloat(index % 9) * g.size.width / 9,
                            y: CGFloat(index / 9) * g.size.width / 9)
                        .onTapGesture {
                            tap(Point(index: index))
                        }
                }
            }
        }
        .background(GameBackground(offset: 8))
        .padding()
    }
    
    func selectedForIndex(_ index: Int) -> Bool {
        selectedPoint == Point(index: index)
    }
    
    func highlightForIndex(_ index: Int) -> GameGridItemView.Highlight? {
        let point = Point(index: index)
        
        if errorPoints.contains(point) {
            return .error
        }
        
        if highlightedPoints.contains(point) {
            return .base
        }
        
        return nil
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameGridView(
            grid: .constant(GridGenerator().makeGameGrid(for: .hard)),
            highlightedPoints: .constant([Point.init(x: 1, y: 1)]),
            errorPoints: .constant([]),
            selectedPoint: .constant(Point(x: 2, y: 2)),
            tap: { _ in })
            .aspectRatio(1, contentMode: .fit)
    }
}
