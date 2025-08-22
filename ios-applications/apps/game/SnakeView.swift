//
//  SnakeView.swift
//  ios-applications
//
//  Created by 비즈비 on 8/22/25.
//

import SwiftUI

struct SnakeView: View {
    @State private var snake = [CGPoint(x: 5, y: 5)]
    @State private var food = CGPoint(x: 10, y: 10)
    @State private var direction = Direction.right
    @State private var gameOver = false
    @State private var score = 0
    @State private var isGameRunning = false
    
    private let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    private let gridSize = 20
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // 게임 정보
                HStack {
                    Text("점수: \(score)")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("크기: \(snake.count)")
                        .font(.headline)
                }
                .padding(.horizontal)
                
                // 게임 보드
                ZStack {
                    // 격자 배경
                    VStack(spacing: 0) {
                        ForEach(0..<gridSize, id: \.self) { row in
                            HStack(spacing: 0) {
                                ForEach(0..<gridSize, id: \.self) { col in
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.1))
                                        .frame(width: 15, height: 15)
                                        .border(Color.gray.opacity(0.3), width: 0.5)
                                }
                            }
                        }
                    }
                    
                    // 뱀
                    ForEach(snake.indices, id: \.self) { index in
                        let point = snake[index]
                        Rectangle()
                            .fill(index == 0 ? Color.green : Color.blue)
                            .frame(width: 15, height: 15)
                            .position(
                                x: CGFloat(point.x) * 15 + 7.5,
                                y: CGFloat(point.y) * 15 + 7.5
                            )
                    }
                    
                    // 먹이
                    Circle()
                        .fill(Color.red)
                        .frame(width: 15, height: 15)
                        .position(
                            x: CGFloat(food.x) * 15 + 7.5,
                            y: CGFloat(food.y) * 15 + 7.5
                        )
                }
                .frame(width: CGFloat(gridSize) * 15, height: CGFloat(gridSize) * 15)
                .background(Color.white)
                .border(Color.gray, width: 2)
                
                // 게임 컨트롤
                VStack(spacing: 16) {
                    // 방향 버튼
                    VStack(spacing: 8) {
                        Button("▲") {
                            if direction != .down {
                                direction = .up
                            }
                        }
                        .buttonStyle(.bordered)
                        .font(.title2)
                        
                        HStack(spacing: 20) {
                            Button("◀") {
                                if direction != .right {
                                    direction = .left
                                }
                            }
                            .buttonStyle(.bordered)
                            .font(.title2)
                            
                            Button("▶") {
                                if direction != .left {
                                    direction = .right
                                }
                            }
                            .buttonStyle(.bordered)
                            .font(.title2)
                        }
                        
                        Button("▼") {
                            if direction != .up {
                                direction = .down
                            }
                        }
                        .buttonStyle(.bordered)
                        .font(.title2)
                    }
                    
                    // 게임 컨트롤
                    HStack(spacing: 20) {
                        Button(isGameRunning ? "일시정지" : "시작") {
                            toggleGame()
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button("재시작") {
                            resetGame()
                        }
                        .buttonStyle(.bordered)
                    }
                }
                
                if gameOver {
                    VStack(spacing: 16) {
                        Text("게임 오버!")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                        
                        Text("최종 점수: \(score)")
                            .font(.headline)
                        
                        Button("다시 시작") {
                            resetGame()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(16)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("스네이크 게임")
            .onReceive(timer) { _ in
                if isGameRunning && !gameOver {
                    moveSnake()
                }
            }
        }
    }
    
    private func toggleGame() {
        isGameRunning.toggle()
    }
    
    private func moveSnake() {
        guard let head = snake.first else { return }
        
        var newHead: CGPoint
        switch direction {
        case .up:
            newHead = CGPoint(x: head.x, y: head.y - 1)
        case .down:
            newHead = CGPoint(x: head.x, y: head.y + 1)
        case .left:
            newHead = CGPoint(x: head.x - 1, y: head.y)
        case .right:
            newHead = CGPoint(x: head.x + 1, y: head.y)
        }
        
        // 벽 충돌 확인
        if newHead.x < 0 || newHead.x >= CGFloat(gridSize) ||
           newHead.y < 0 || newHead.y >= CGFloat(gridSize) {
            gameOver = true
            isGameRunning = false
            return
        }
        
        // 자기 자신과 충돌 확인
        if snake.contains(newHead) {
            gameOver = true
            isGameRunning = false
            return
        }
        
        snake.insert(newHead, at: 0)
        
        // 먹이 확인
        if newHead == food {
            score += 10
            generateFood()
        } else {
            snake.removeLast()
        }
    }
    
    private func generateFood() {
        var newFood: CGPoint
        repeat {
            newFood = CGPoint(
                x: CGFloat.random(in: 0..<CGFloat(gridSize)),
                y: CGFloat.random(in: 0..<CGFloat(gridSize))
            )
        } while snake.contains(newFood)
        
        food = newFood
    }
    
    private func resetGame() {
        snake = [CGPoint(x: 5, y: 5)]
        direction = .right
        food = CGPoint(x: 10, y: 10)
        gameOver = false
        score = 0
        isGameRunning = false
    }
}

enum Direction {
    case up, down, left, right
}

#Preview {
    SnakeView()
}
