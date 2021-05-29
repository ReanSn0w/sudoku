//
//  AvaliableNumbersView.swift
//  sudoku
//
//  Created by Дмитрий Папков on 05.05.2021.
//

import SwiftUI

struct AvaliableNumbersView: View {
    var avaliableNumbers: Set<Int>
    @Binding var selectedNumber: Int?
    var doStep: () -> Void = {}
    
    var body: some View {
        GeometryReader { g in
            Group {
                ForEach(1...9, id: \.self) { number in
                    Button(action: {
                        selectedNumber = number
                        doStep()
                    }) {
                        GameGridItemView(
                            number,
                            highlight: selectedNumber == number ? .base : nil,
                            selected: false)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(
                        width: g.size.width / 9,
                        height: g.size.width / 9,
                        alignment: .center)
                    .offset(
                        x: CGFloat((number - 1) % 9) * g.size.width / 9)
                    .opacity(avaliableNumbers.contains(number) ? 1 : 0.3)
                }
            }
        }
        .padding()
    }
}

struct AvaliableNumbersView_Previews: PreviewProvider {
    static var previews: some View {
        AvaliableNumbersView(
            avaliableNumbers: Set(1...5),
            selectedNumber: .constant(3))
            .aspectRatio(9, contentMode: .fit)
    }
}
