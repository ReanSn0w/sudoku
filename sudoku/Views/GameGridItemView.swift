//
//  GameGridItemView.swift
//  sudoku
//
//  Created by Дмитрий Папков on 05.05.2021.
//

import SwiftUI

struct GameGridItemView: View {
    var number: Int?
    var highlight: Highlight?
    var selected: Bool
    
    init(_ number: Int?
         , highlight: Highlight?
         , selected: Bool) {
        self.number = number
        self.highlight = highlight
        self.selected = selected
    }
    
    var value: String {
        guard let number = number else {
            return ""
        }
        
        return String(number)
    }
    
    var body: some View {
        ZStack {
            if highlight != nil {
                highlight!.color
                    .opacity(0.5)
            }
            
            Color.gray
                .opacity(0.2)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: selected ? 5 : 0)
        )
        .cornerRadius(5)
        .padding(2)
        .overlay(Text(value))
    }
    
    enum Highlight {
        case base
        case error
        case other(Color)
        
        var color: Color {
            switch self {
            case .base:
                return .accentColor
            case .error:
                return .red
            case .other(let color):
                return color
            }
        }
    }
}

struct GameGridItemView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            GameGridItemView(
                2,
                highlight: .base,
                selected: true)
                .frame(width: 40, height: 40)
            
            GameGridItemView(
                2,
                highlight: .base,
                selected: false)
                .frame(width: 40, height: 40)
            
            GameGridItemView(
                2,
                highlight: nil,
                selected: false)
                .frame(width: 40, height: 40)
            
            GameGridItemView(
                nil,
                highlight: .error,
                selected: true)
                .frame(width: 40, height: 40)
            
            GameGridItemView(
                nil,
                highlight: .error,
                selected: false)
                .frame(width: 40, height: 40)
        }
        .accentColor(.red)
    }
}
