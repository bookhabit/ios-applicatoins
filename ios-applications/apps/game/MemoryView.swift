//
//  MemoryView.swift
//  ios-applications
//
//  Created by 비즈비 on 8/22/25.
//

import SwiftUI

struct MemoryView: View {
    @State private var cards: [MemoryCard] = []
    @State private var flippedCards: [Int] = []
    @State private var matchedPairs: [Int] = []
    @State private var moves = 0
    @State private var gameOver = false
    @State private var showingNewGame = false
    
    private let symbols = ["🌟", "🎈", "🎨", "🎭", "🎪", "🎯", "🎲", "🎮"]
    private let gridSize = 4
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // 게임 정보
                HStack {
                    Text("이동: \(moves)")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("매치: \(matchedPairs.count / 2)")
                        .font(.headline)
                }
                .padding(.horizontal)
                
                // 게임 보드
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: gridSize), spacing: 8) {
                    ForEach(cards.indices, id: \.self) { index in
                        MemoryCardView(
                            card: cards[index],
                            isFlipped: flippedCards.contains(index) || matchedPairs.contains(index),
                            isMatched: matchedPairs.contains(index)
                        ) {
                            flipCard(at: index)
                        }
                    }
                }
                .padding()
                
                // 게임 컨트롤
                HStack(spacing: 20) {
                    Button("새 게임") {
                        showingNewGame = true
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button("초기화") {
                        resetGame()
                    }
                    .buttonStyle(.bordered)
                }
                
                if gameOver {
                    VStack(spacing: 16) {
                        Text("🎉 게임 완료! 🎉")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                        
                        Text("총 이동: \(moves)")
                            .font(.headline)
                        
                        Text("총 매치: \(matchedPairs.count / 2)")
                            .font(.headline)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(16)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("메모리 게임")
            .onAppear {
                setupGame()
            }
            .alert("새 게임", isPresented: $showingNewGame) {
                Button("시작") {
                    setupGame()
                }
                Button("취소", role: .cancel) { }
            } message: {
                Text("새로운 게임을 시작하시겠습니까?")
            }
        }
    }
    
    private func setupGame() {
        var newCards: [MemoryCard] = []
        
        // 각 심볼을 2개씩 생성
        for symbol in symbols {
            newCards.append(MemoryCard(symbol: symbol, id: UUID()))
            newCards.append(MemoryCard(symbol: symbol, id: UUID()))
        }
        
        // 카드 순서 섞기
        cards = newCards.shuffled()
        flippedCards.removeAll()
        matchedPairs.removeAll()
        moves = 0
        gameOver = false
    }
    
    private func flipCard(at index: Int) {
        // 이미 뒤집혀있거나 매치된 카드는 무시
        if flippedCards.contains(index) || matchedPairs.contains(index) {
            return
        }
        
        // 카드 뒤집기
        flippedCards.append(index)
        
        // 두 번째 카드가 뒤집혔을 때 매치 확인
        if flippedCards.count == 2 {
            moves += 1
            
            let firstIndex = flippedCards[0]
            let secondIndex = flippedCards[1]
            
            if cards[firstIndex].symbol == cards[secondIndex].symbol {
                // 매치 성공
                matchedPairs.append(firstIndex)
                matchedPairs.append(secondIndex)
                flippedCards.removeAll()
                
                // 게임 완료 확인
                if matchedPairs.count == cards.count {
                    gameOver = true
                }
            } else {
                // 매치 실패 - 잠시 후 뒤집기
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    flippedCards.removeAll()
                }
            }
        }
    }
    
    private func resetGame() {
        setupGame()
    }
}

struct MemoryCard: Identifiable {
    let symbol: String
    let id: UUID
}

struct MemoryCardView: View {
    let card: MemoryCard
    let isFlipped: Bool
    let isMatched: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(isMatched ? Color.green.opacity(0.3) : Color.blue.opacity(0.3))
                    .frame(height: 80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(isMatched ? Color.green : Color.blue, lineWidth: 2)
                    )
                
                if isFlipped {
                    Text(card.symbol)
                        .font(.system(size: 30))
                } else {
                    Text("?")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.white)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isFlipped ? 1.0 : 0.95)
        .animation(.easeInOut(duration: 0.2), value: isFlipped)
    }
}

#Preview {
    MemoryView()
}
