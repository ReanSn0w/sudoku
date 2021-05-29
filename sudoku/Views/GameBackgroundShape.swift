//
//  GameBackgroundShape.swift
//  sudoku
//
//  Created by Дмитрий Папков on 17.05.2021.
//

import SwiftUI

struct GameBackground: Shape {
    var offset: CGFloat = 5
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            
            for item in 1...12 {
                let vertical = item < 7
                let line = (vertical ? item : item - 6) / 4 != 1
                let block = CGFloat(item - ((vertical ? 0 : 1) * 6) - ((line ? 0 : 1) *  3))
                let size = CGSize(
                    width: vertical ? 1 : (rect.width - offset * 6) / 3,
                    height: vertical ? (rect.width - offset * 6) / 3 : 1)
                let origin = CGPoint(
                    x: vertical ? (rect.maxX - 1) / 3 * (line ? 1 : 2) : (rect.maxX - 1) / 3 * (block - 1) + offset,
                    y: vertical ? (rect.maxY - 1) / 3 * (block - 1) + offset : (rect.maxY - 1) / 3 * (line ? 1 : 2))
                
                path.addPath(
                    Rectangle()
                        .path(in: .init(
                            origin: origin,
                            size: size)))
            }
            
//            path.addPath(
//                Rectangle()
//                    .path(in: .init(
//                            origin: .init(x: (rect.maxX - 2) / 3 , y: rect.minY + offset),
//                            size: .init(width: 1, height: rect.height - offset * 2))))
//
//            path.addPath(
//                Rectangle()
//                    .path(in: .init(
//                            origin: .init(x: (rect.maxX - 2) / 3 * 2 + 1, y: rect.minY + offset),
//                            size: .init(width: 1, height: rect.height - offset * 2))))
//
//            path.addPath(
//                Rectangle()
//                    .path(in: .init(
//                            origin: .init(x: rect.minX + offset, y: (rect.maxY - 2) / 3),
//                            size: .init(width: rect.width - offset * 2, height: 1))))
//
//            path.addPath(
//                Rectangle()
//                    .path(in: .init(
//                            origin: .init(x: rect.minX + offset, y: (rect.maxY - 2) / 3 * 2 + 1),
//                            size: .init(width: rect.width - offset * 2, height: 1))))
        }
    }
}

struct GameBackground_Previews: PreviewProvider {
    static var previews: some View {
        GameBackground()
            .aspectRatio(1, contentMode: .fit)
            .background(Color.blue)
    }
}
