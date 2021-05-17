//
//  GameGridItemView.swift
//  sudoku
//
//  Created by Дмитрий Папков on 05.05.2021.
//

import SwiftUI

struct GameGridItemView: View {
    var number: Int?
    var highlighted: Bool
    var selected: Bool
    
    init(_ number: Int?
         , highlighted: Bool
         , selected: Bool) {
        self.number = number
        self.highlighted = highlighted
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
            if highlighted {
                Color.accentColor
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
}

struct GameGridItemView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            GameGridItemView(
                2,
                highlighted: true,
                selected: true)
                .frame(width: 40, height: 40)
            
            GameGridItemView(
                2,
                highlighted: true,
                selected: false)
                .frame(width: 40, height: 40)
            
            GameGridItemView(
                2,
                highlighted: false,
                selected: false)
                .frame(width: 40, height: 40)
            
            GameGridItemView(
                nil,
                highlighted: false,
                selected: true)
                .frame(width: 40, height: 40)
            
            GameGridItemView(
                nil,
                highlighted: false,
                selected: false)
                .frame(width: 40, height: 40)
        }
        .accentColor(.red)
    }
}
