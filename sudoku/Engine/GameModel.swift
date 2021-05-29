//
//  GameModel.swift
//  sudoku
//
//  Created by Дмитрий Папков on 11.05.2021.
//

import SwiftUI
import Combine

class GameModel: ObservableObject, Identifiable {
    private let difficulty: GridGenerator.Difficulty
    private(set) var timer: Publishers.Autoconnect<Timer.TimerPublisher>
    let startGrid: GameGrid
    
    @Published var seconds: Int = 0
    
    @Published private var history = GameHistory() {
        didSet { validateGrid()}
    }
    
    @Published private var point: Point? = nil
    
    @Published var selectedNumber: Int? = nil
    
    /// данные значения задаются методом validateField
    /// его вызов производится после изменения в истории
    @Published var avaliableNumbers: Set<Int> = .init()
    @Published var wrongPoints: [Point] = []
    
    init(_ difficulty: GridGenerator.Difficulty) {
        let generator = GridGenerator()
        
        self.difficulty = difficulty
        self.startGrid = generator.makeGameGrid(for: difficulty)
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
        validateGrid()
    }
    
    func endActions() {
        guard gameEnded.wrappedValue else { return }
        
        GameCenter.shared.sendScore(
            self.score,
            difficulty: difficulty)
    }
    
    func doStep() {
        guard
            let point = point,
            let number = selectedNumber,
            startGrid[point.index] == nil
        else {
            print("Попытка совершения невозможного хода")
            return
        }
        
        history.addStep(Step.init(point, value: number, score: timeScore))
        self.point = nil
    }
    
    func undoStep() {
        _ = history.deleteStep()
    }
}

extension GameModel {
    private var gameGrid: GameGrid {
        var grid = startGrid
        history.forEach { step in grid[step.dot.index] = step.value }
        return grid
    }
    
    /// проперти для рассчета очков по таймеру
    private var timeScore: Int {
        let val = 1000 - seconds
        return val < 400 ? 400 : val
    }
    
    var gameTimer: String {
        let hour = seconds / 60 / 60
        let minute = seconds / 60 - hour * 60
        let second = seconds - hour * 60 - minute * 60
        
        return "\(hour < 10 ? "0" : "")\(hour):\(minute < 10 ? "0" : "")\(minute):\(second < 10 ? "0" : "")\(second)"
    }
    
    var score: Int {
        history.score
    }
    
    var bindingGrid: Binding<GameGrid> {
        .constant(gameGrid)
    }
    
    var gameEnded: Binding<Bool> {
        .constant(!gameGrid.contains(nil) && wrongPoints.isEmpty)
    }
    
    var highlightedPoints: Binding<[Point]> {
        guard let number = selectedNumber else {
            return .constant([])
        }
        
        var indexes: [Int] = []
            
        for (index, val) in gameGrid.enumerated() {
            if val == number {
                indexes.append(index)
            }
        }
        
        return .constant(indexes.map({ Point(index: $0) }))
    }
    
    var selectedPoint: Binding<Point?> {
        .init {
            self.point
        } set: { newPoint in
            guard let newPoint = newPoint else {
                self.point = nil
                return
            }
            
            /// Проверка: необходимо ли подсветить поле
            if self.gameGrid[newPoint.index] != nil {
                self.selectedNumber = self.gameGrid[newPoint.index]
            }
            
            /// запрет на выбор поля представленного по умолчанию
            guard self.startGrid[newPoint.index] == nil else {
                self.point = nil
                return
            }
            
            self.point = newPoint
        }
    }
}

extension GameModel {
    private func validateGrid() {
        var numMap: [Int?: [Point]] = [:]
        
        gameGrid.enumerated().forEach { val in
            numMap[val.element, default: []]
                .append(Point(index: val.offset))
        }
        
        /// Установка среза доступных чисел
        setAvaliableNumbers(numMap)
        
        /// Установка массива неправильных чисел
        setWrongPoints(numMap)
    }
    
    private func setAvaliableNumbers(_ numMap: [Int?: [Point]]) {
        var avaliableNumbers: Set<Int> = .init()
        
        for (number, points) in numMap {
            guard let number = number else {
                continue
            }
            
            if points.count < 9 {
                avaliableNumbers.insert(number)
            }
        }
        
        self.avaliableNumbers = avaliableNumbers
    }
    
    private func setWrongPoints(_ numMap: [Int? : [Point]]) {
        var invalidPoints: [Point] = []
        
        for (num, points) in numMap {
            guard num != nil else { continue }
            
            for (index, point) in points.enumerated() {
                for (index2, point2) in points.enumerated() {
                    if index2 <= index { continue }
                    
                    if point.x == point2.x || point.y == point2.y || point.square == point2.square {
                        /// тут я прямо забил на то что элементы будут дублироваться и так очень стремно получилось, стоит потом сюда вернуться
                        invalidPoints.append(point)
                        invalidPoints.append(point2)
                    }
                }
            }
        }
        
        self.wrongPoints = invalidPoints
    }
}
