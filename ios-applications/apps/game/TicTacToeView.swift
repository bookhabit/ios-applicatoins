//
//  TicTacToeView.swift
//  ios-applications
//
//  Created by 비즈비 on 8/22/25.
//

import SwiftUI

struct TicTacToeView: View {
    @State private var board = Array(repeating: "", count: 9)
    @State private var currentPlayer = "X"
    @State private var gameOver = false
    @State private var winner = ""
    @State private var gameHistory: [GameMove] = []
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // 게임 상태
                VStack(spacing: 16) {
                    Text("현재 플레이어: \(currentPlayer)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(currentPlayer == "X" ? .blue : .red)
                    
                    if !winner.isEmpty {
                        Text("승자: \(winner)")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                    }
                }
                
                // 게임 보드
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 8) {
                    ForEach(0..<9, id: \.self) { index in
                        Button(action: {
                            makeMove(at: index)
                        }) {
                            Text(board[index])
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(board[index] == "X" ? .blue : .red)
                                .frame(width: 80, height: 80)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(12)
                        }
                        .disabled(board[index] != "" || gameOver)
                    }
                }
                .padding()
                
                // 게임 컨트롤
                HStack(spacing: 20) {
                    Button("게임 재시작") {
                        resetGame()
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button("무르기") {
                        undoMove()
                    }
                    .buttonStyle(.bordered)
                    .disabled(gameHistory.isEmpty)
                }
                
                // 게임 히스토리
                if !gameHistory.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("게임 히스토리")
                            .font(.headline)
                        
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 4) {
                                ForEach(gameHistory.indices, id: \.self) { index in
                                    let move = gameHistory[index]
                                    Text("\(index + 1). \(move.player)가 \(move.position + 1)번 위치에 배치")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .frame(height: 100)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("틱택토")
        }
    }
    
    private func makeMove(at position: Int) {
        guard board[position] == "" && !gameOver else { return }
        
        board[position] = currentPlayer
        gameHistory.append(GameMove(player: currentPlayer, position: position))
        
        if checkWinner() {
            gameOver = true
            winner = currentPlayer
        } else if board.allSatisfy({ $0 != "" }) {
            gameOver = true
            winner = "무승부"
        } else {
            currentPlayer = currentPlayer == "X" ? "O" : "X"
        }
    }
    
    private func checkWinner() -> Bool {
        let winningCombinations = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], // 가로
            [0, 3, 6], [1, 4, 7], [2, 5, 8], // 세로
            [0, 4, 8], [2, 4, 6] // 대각선
        ]
        
        for combination in winningCombinations {
            if board[combination[0]] != "" &&
               board[combination[0]] == board[combination[1]] &&
               board[combination[1]] == board[combination[2]] {
                return true
            }
        }
        return false
    }
    
    private func resetGame() {
        board = Array(repeating: "", count: 9)
        currentPlayer = "X"
        gameOver = false
        winner = ""
        gameHistory.removeAll()
    }
    
    private func undoMove() {
        guard let lastMove = gameHistory.last else { return }
        
        board[lastMove.position] = ""
        gameHistory.removeLast()
        currentPlayer = lastMove.player
        gameOver = false
        winner = ""
    }
}

struct GameMove {
    let player: String
    let position: Int
}

#Preview {
    TicTacToeView()
}
