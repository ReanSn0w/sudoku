//
//  Point.swift
//  sudoku
//
//  Модель для описания положения элемента на игровом поле
//
//  Created by Дмитрий Папков on 23.05.2021.
//

import Foundation

class Point {
    let x: Int
    let y: Int

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

extension Point {
    convenience init(index: Int) {
        self.init(
            x: index % 9,
            y: index / 9)
    }
    
    var index: Int {
        x + y * 9
    }
    
    var square: Int {
        let x = self.x / 3
        let y = self.y / 3
        return x*3 + y
    }
}

extension Point: Equatable {
    static func == (lhs: Point, rhs: Point) -> Bool {
        lhs.x == rhs.x && lhs.y == rhs.y
    }
}
