//
//  ScoresScene.swift
//  sudoku
//
//  Created by Дмитрий Папков on 29.05.2021.
//

import SwiftUI

struct ScoresScene: View {
    @ObservedObject var gameCenter: GameCenter = .shared
    
    var body: some View {
        List {
            Section(header: Text("Очки")) {
                ForEach(GridGenerator.Difficulty.allCases, id: \.self) { difficulty in
                    HStack {
                        Text(difficulty.name)
                            .font(.headline)
                        Spacer()
                        Text(loadScore(for: difficulty))
                            .font(.subheadline)
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(Text("Результаты"))
    }
    
    func loadScore(for difficulty: GridGenerator.Difficulty) -> String {
        let score = gameCenter.scores[difficulty.scoreLeaderboardID] ?? 0
        return "\(score)"
    }
}

struct ScoresScene_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScoresScene()
        }
    }
}
