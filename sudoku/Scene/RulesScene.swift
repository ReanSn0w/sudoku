//
//  RulesScene.swift
//  sudoku
//
//  Created by Дмитрий Папков on 17.05.2021.
//

import SwiftUI

struct RulesScene: View {
    let previews: FieldsPreviews = .init()
    let rulesText: RulesText = .init()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                block(title: rulesText.firstTitle) {
                    Text(rulesText.firstText)
                }
                        
                block(title: rulesText.secondTitle) {
                    NewGameGridView(
                        grid: .constant(previews.previewGrid),
                        highlightedPoints: .constant(previews.firstHighlightedPoints),
                        errorPoints: .constant([]),
                        selectedPoint: .constant(nil),
                        tap: {_ in })
                        .aspectRatio(1, contentMode: .fit)
                        .frame(maxWidth: 500)
                    
                    Text(rulesText.secondTextPartOne)
                    Text(rulesText.secondTextPartTwo)
                }
                
                block(title: rulesText.thridTitle) {
                    Text(rulesText.thridText)
                }
                
                block(title: rulesText.forthTitle) {
                    Text(rulesText.forthTextPartOne)
                    Text(rulesText.forthTextPartTwo)
                    
                    NewGameGridView(
                        grid: .constant(previews.previewGrid),
                        highlightedPoints: .constant(previews.secondHighligtedPoints),
                        errorPoints: .constant(previews.secondErrorPoints),
                        selectedPoint: .constant(previews.secondSelectedField),
                        tap: {_ in })
                        .aspectRatio(1, contentMode: .fit)
                        .frame(maxWidth: 500)
                    
                    Text(rulesText.forthTextPartThree)
                    Text(rulesText.forthTextPartFour)
                }
                
                Link("Источник: sudoku.com", destination: URL(string: "https://sudoku.com/ru/kak-igrat/pravila-igry-sudoku-dla-nacinausih/")!)
                    .font(.caption)
            }
            .frame(maxWidth: 700)
            .padding()
        }
        .navigationTitle(Text("Правила игры"))
    }
    
    func block<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title3)
            
            content()
        }
    }
}

struct RulesScene_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RulesScene()
        }
    }
}

class FieldsPreviews {
    let previewGrid: GameGrid = [
        nil, 7, 2, nil, nil, 4, 9, nil, nil,
        3, nil, 4, nil, 8, 9, 1, nil, nil,
        8, 1, 9, nil, nil, 6, 2, 5, 4,
        7, nil, 1, nil, nil, nil, nil, 9, 5,
        9, nil, nil, nil, nil, 2, nil, 7, nil,
        nil, nil, nil, 8, nil, 7, nil, 1, 2,
        4, nil, 5, nil, nil, 1, 6, 2, nil,
        2, 3, 7, nil, nil, nil, 5, nil, 1,
        nil, nil, nil, nil, 2, 5, 7, nil, nil
    ]
    
    let firstHighlightedPoints: [CGPoint] = [
        CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 0, y: 2),
        CGPoint(x: 1, y: 0), CGPoint(x: 1, y: 1), CGPoint(x: 1, y: 2),
        CGPoint(x: 2, y: 0), CGPoint(x: 2, y: 1), CGPoint(x: 2, y: 2)
    ]
    
    let secondHighligtedPoints: [CGPoint] = [
        CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1), CGPoint(x: 0, y: 2),
        CGPoint(x: 0, y: 3), CGPoint(x: 0, y: 4), CGPoint(x: 0, y: 5),
        CGPoint(x: 0, y: 6), CGPoint(x: 0, y: 7), CGPoint(x: 0, y: 8)
    ]
    
    let secondErrorPoints: [CGPoint] = [
        CGPoint(x: 1, y: 2), CGPoint(x: 2, y: 3)
    ]
    
    let secondSelectedField: CGPoint? = CGPoint(x: 0, y: 8)
}

class RulesText {
    var firstTitle: String = "Используйте цифры от 1 до 9"
    
    var firstText: String = "Судоку играется на игровом поле, состоящем из 9 на 9 клеток, всего 81 клетка. Внутри игрового поля находятся 9 \"квадратов\" (состоящих из 3 x 3 клеток). Каждая горизонтальная строка, вертикальный столбец и квадрат (9 клеток каждый) должны заполняться цифрами 1-9, не повторяя никаких чисел в строке, столбце или квадрате. Это звучит сложно? Как видно из изображения ниже, каждое игровое поле Судоку имеет несколько клеток, которые уже заполнены. Чем больше клеточек изначально заполнено, тем легче игра. Чем меньше клеток изначально заполнено, тем труднее игра."
    
    var secondTitle: String = "Не повторяйте никакие числа"
    
    var secondTextPartOne: String = "Как вы можете видеть, в верхнем левом квадрате (обведен синим) уже заполнены 7 из 9 клеток. Единственные числа, которые отсутствуют в этом квадрате, это числа 5 и 6. Видя, какие числа отсутствуют в каждом квадрате, строке или столбце, мы можем использовать процесс исключения и дедуктивное мышление, чтобы решить, какие числа должны находиться в каждой клетке."
    
    var secondTextPartTwo: String = "Например, в верхнем левом квадрате мы знаем, что для завершения квадрата нужно добавить числа 5 и 6, но глядя на соседние строки и квадраты мы пока не можем четко определить, какое число добавить в какую клетку. Это означает, что теперь мы должны пока пропустить верхний левый квадрат и вместо этого попытаться заполнить пробелы в некоторых других местах игрового поля."
    
    var thridTitle: String = "Не нужно гадать"
    
    var thridText: String = "Судоку – это логическая игра, поэтому не нужно гадать. Если вы не знаете, какое число поставить в определенную клетку, продолжайте сканировать другие области игрового поля, пока не увидите возможность вставить нужное число. Но не пытайтесь \"форсировать\" что-либо - Судоку вознаграждает за терпение, понимание и решение различных комбинаций, а не за слепое везение или угадывание."
    
    var forthTitle: String = "Используйте метод исключения"
    
    var forthTextPartOne: String = "Что мы делаем, когда используем \"метод исключения\" в игре Судоку? Вот пример. В этой сетке Судоку (показано ниже) в левом вертикальном столбце (обведен синим) отсутствуют только нескольких чисел: 1, 5 и 6."
    
    var forthTextPartTwo: String = "Один из способов выяснить, какие числа можно вставить в каждую клетку - это использовать \"метод исключения\", проверяя, какие другие числа уже имеются в каждом квадрате, поскольку не допускается дублирование чисел 1-9 в каждом квадрате, строке или столбце."
    
    var forthTextPartThree: String = "В этом случае мы можем быстро заметить, что в верхнем левом и центральном левом квадратах уже есть число 1 (числа 1 обведены красным). Это означает, что в крайнем левом столбце есть только одно место, в которое можно вставить число 1 (обведено зеленым). Вот как метод исключения работает в Судоку - вы узнаете, какие клетки свободны, какие числа отсутствуют, а затем исключаете числа, которые уже присутствуют в квадрате, столбцах и рядах. Соответственно заполняете пустые клетки отсутствующими числами."
    
    var forthTextPartFour: String = "Правила Судоку относительно несложные - но игра необычайно разнообразна, с миллионами возможных комбинаций чисел и широким диапазоном уровней сложности. Но все это основано на простых принципах использования чисел 1-9, заполнении пробелов на основе дедуктивного мышления и никогда не повторяющихся чисел в каждом квадрате, строке или столбце."
}
