//
//  Step.swift
//  sudoku
//
//  Step - Класс для описания хода в игре
//
//  GameHistory - История ходов сделанных игроком за игру
/// История содержит воспомогательные методы для корректировки результата
/// пользователя выразаемого в очках
//
//  Created by Дмитрий Папков on 23.05.2021.
//

import Foundation

class Step {
    var dot: Point
    var value: Int
    var score: Int
    
    init(_ dot: Point, value: Int, score: Int) {
        self.dot = dot
        self.value = value
        self.score = score
    }
}

typealias GameHistory = [Step]

extension GameHistory {
    var score: Int {
        var score: Int = 0
        
        for step in self {
            score += step.score
        }
        
        return score
    }
    
    mutating func addStep(_ step: Step) {
        step.score = step.score - (self.first(where: { val in
            val.dot == step.dot
        })?.score ?? 0)
        
        self.append(step)
    }
    
    mutating func deleteStep() -> Step {
        self.removeLast()
    }
}
