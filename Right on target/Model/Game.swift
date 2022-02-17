//
//  Game.swift
//  Right on target
//
//  Created by justSmK on 16.02.2022.
//

import Foundation

protocol GameProtocol {
    associatedtype SecretType
    var score: Int { get }
    var secretValue: SecretType { get }
    var isGameEnded: Bool { get }
    func restartGame()
    func startNewRound()
    func calculateScore(secretValue: SecretType, userValue: SecretType)
}

class Game<T: SecretValueProtocol>: GameProtocol {
    typealias SecretType = T
    var score: Int = 0
    // секретное значение
    var secretValue: T
    // замыкание производит сравнение значений и возвращает заработанные очки
    private var compareClosure: (T, T) -> Int
    private var roundsCount: Int!
    private var currentRoundNumber: Int = 0
    var isGameEnded: Bool {
        if currentRoundNumber == roundsCount {
            return true
        } else {
            return false
        }
    }
    
    init(secretValue: T, rounds: Int, compareClosure: @escaping (T, T) -> Int) {
        self.secretValue = secretValue
        roundsCount = rounds
        self.compareClosure = compareClosure
        startNewRound()
    }
    
    func restartGame() {
        score = 0
        currentRoundNumber = 0
        startNewRound()
    }
    
    func startNewRound() {
        currentRoundNumber += 1
        self.secretValue.setRandomValue()
    }
    
    func calculateScore(secretValue: T, userValue: T) {
        score = score + compareClosure(secretValue, userValue)
    }
    
}
