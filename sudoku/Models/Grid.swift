//
//  Grid.swift
//  sudoku
//
//  Created by Дмитрий Папков on 04.05.2021.
//

import SwiftUI

typealias Grid = [Int]
typealias GameGrid = [Int?]

class GridGenerator {
    private static let defultGrid: Grid = [
        1,2,3,4,5,6,7,8,9,
        4,5,6,7,8,9,1,2,3,
        7,8,9,1,2,3,4,5,6,
        2,3,4,5,6,7,8,9,1,
        5,6,7,8,9,1,2,3,4,
        8,9,1,2,3,4,5,6,7,
        3,4,5,6,7,8,9,1,2,
        6,7,8,9,1,2,3,4,5,
        9,1,2,3,4,5,6,7,8
    ]
    
    private(set) var grid: Grid
    
    init() {
        self.grid = GridGenerator.defultGrid
        self.shuffleGrid()
    }
    
    func makeGameGrid(for difficulty: Difficulty) -> GameGrid {
        var game: GameGrid = grid
        let indexes = Array(0...80).shuffled()
        
        for i in 0..<difficulty.rawValue {
            game[indexes[i]] = nil
        }
        
        return game
    }
    
    private func shuffleGrid() {
        for _ in 0 ..< 64 {
            let shuffleType = ChangeVariant.allCases.randomElement()!
            let first = [0,1,2].randomElement()!
            let second = [0,1,2].randomElement()!
            let block = [0,1,2].randomElement()!
            
            switch shuffleType {
            case .hLine:
                changeHLine(first: first, second: second, block: block)
            case .vLine:
                changeVLine(first: first, second: second, block: block)
            case .hBlock:
                changeHStack(first: first, second: second)
            case .vBlock:
                changeVStack(first: first, second: second)
            case .transporate:
                transpose()
            }
        }
    }
    
    private func changeVStack(first: Int, second: Int) {
        guard first >= 0, first < 3, second >= 0, second < 3, first != second else { return }
        
        for i in 0..<3 {
            unsecureChangeVLine(firstLine: first*3 + i, secondLine: second*3 + i)
        }
    }
    
    private func changeHStack(first: Int, second: Int) {
        guard first >= 0, first < 3, second >= 0, second < 3, first != second else { return }
        
        for i in 0..<3 {
            unsecureChangeHLine(firstLine: first*3 + i, secondLine: second*3 + i)
        }
    }
    
    private func changeVLine(first: Int, second: Int, block: Int) {
        guard first >= 0, first < 3, second >= 0, second < 3, block >= 0, block < 3, first != second else { return }
        unsecureChangeVLine(firstLine: first+block*3, secondLine: second+block*3)
    }
    
    private func changeHLine(first: Int, second: Int, block: Int) {
        guard first >= 0, first < 3, second >= 0, second < 3, block >= 0, block < 3, first != second else { return }
        unsecureChangeHLine(firstLine: first+block*3, secondLine: second+block*3)
    }
    
    private func transpose() {
        for i in 0..<9 {
            guard i == 0 else { continue }
            
            for g in 0..<i {
                change(firstIndex: indexBy(x: g, y: i), secondIndex: indexBy(x: i, y: g))
            }
        }
    }
    
    private func unsecureChangeVLine(firstLine: Int, secondLine: Int) {
        for i in 0..<9 {
            change(firstIndex: indexBy(x: firstLine, y: i), secondIndex: indexBy(x: secondLine, y: i))
        }
    }
    
    private func unsecureChangeHLine(firstLine: Int, secondLine: Int) {
        for i in 0..<9 {
            change(firstIndex: indexBy(x: i, y: firstLine), secondIndex: indexBy(x: i, y: secondLine))
        }
    }
    
    private func change(firstIndex: Int, secondIndex: Int) {
        grid[firstIndex] += grid[secondIndex]
        grid[secondIndex] = grid[firstIndex] - grid[secondIndex]
        grid[firstIndex] = grid[firstIndex] - grid[secondIndex]
    }
    
    private func indexBy(x: Int, y: Int) -> Int { return x * 9 + y }
    
    enum ChangeVariant:CaseIterable {
        case hLine
        case vLine
        case hBlock
        case vBlock
        case transporate
    }
    
    enum Difficulty: Int {
        case flash = 10
        case easy  = 20
        case medium = 30
        case hard = 40
        case insane = 50
    }
}
