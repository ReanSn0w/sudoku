//
//  GameKit.swift
//  sudoku
//
//  Created by Дмитрий Папков on 25.05.2021.
//

import Foundation
import GameKit

class GameCenter: ObservableObject {
    static let shared: GameCenter = .init()
    
    @Published var scores: [String: Int] = [:]
    
    private let localPlayer = GKLocalPlayer.local
    
    private init() {
        GKAccessPoint.shared.location = .bottomLeading
        
        self.authentificateUser()
    }
    
    var isAuthentificated: Bool {
        self.localPlayer.isAuthenticated
    }
    
    var gameKitAccessPoint: Bool {
        get { GKAccessPoint.shared.isActive }
        set(newValue) { GKAccessPoint.shared.isActive = newValue }
    }
    
    func authentificateUser() {
        localPlayer.authenticateHandler = {[weak self] vc, err in
            guard err == nil, let self = self else {
                print(err?.localizedDescription ?? "other error")
                return
            }
            
            self.gameKitAccessPoint = true
            self.objectWillChange.send()
        }
    }
    
    func getScores() {
        let leaderboardIds = GridGenerator.Difficulty.allCases.map({ $0.scoreLeaderboardID })
        
        GKLeaderboard.loadLeaderboards(IDs: leaderboardIds) { [weak self] leaderboards, error in
            guard error == nil,
                  let leaderboards = leaderboards,
                  let self = self
            else {
                print(error?.localizedDescription ?? "Не удалось получить доски рекордов")
                return
            }
            
            leaderboards.forEach { leaderboard in
                leaderboard.loadEntries(for: [self.localPlayer], timeScope: .allTime) { entry, _, error in
                    guard error == nil,
                          let entry = entry
                    else {
                        print(error?.localizedDescription ?? "Не удалось получить результат для таблицы \(leaderboard.baseLeaderboardID)")
                        return
                    }
                    
                    self.scores[leaderboard.baseLeaderboardID] = entry.score
                }
            }
        }
    }
    
    func sendScore(_ score: Int, difficulty: GridGenerator.Difficulty) {
        guard !self.scores.isEmpty,
              self.scores[difficulty.scoreLeaderboardID] ?? 0 < score
        else {
            return
        }
        
        self.saveScore(to: difficulty.scoreLeaderboardID, score: score)
    }
    
//    func sendTime(_ time: TimeInterval, difficulty: GridGenerator.Difficulty) {
//
//    }
    
    func saveScore(to leaderboard: String, score: Int) {
        GKLeaderboard.loadLeaderboards(IDs: [leaderboard]) { [weak self] leaderboards, err in
            guard let self = self,
                  let leaderboard = leaderboards?.first
            else  {
                return
            }
            
            leaderboard.submitScore(score, context: 0, player: self.localPlayer) { error in
                if let err = err {
                    print(err.localizedDescription)
                }
            }
        }
    }
}

extension GridGenerator.Difficulty {
    var scoreLeaderboardID: String {
        switch self {
        case .flash:
            return "com.nsnow.sudoku.flash.score"
        case .easy:
            return "com.nsnow.sudoku.easy.score"
        case .medium:
            return "com.nsnow.sudoku.medium.score"
        case .hard:
            return "com.nsnow.sudoku.hard.score"
        case .insane:
            return "com.nsnow.sudoku.insane.score"
        }
    }
    
    // timeLeaderboardID - зарезервировано на потом
    var timeLeaderboardID: String {
        switch self {
        case .flash:
            return "com.nsnow.sudoku.flash.time"
        case .easy:
            return "com.nsnow.sudoku.easy.time"
        case .medium:
            return "com.nsnow.sudoku.medium.time"
        case .hard:
            return "com.nsnow.sudoku.hard.time"
        case .insane:
            return "com.nsnow.sudoku.insane.time"
        }
    }
}
