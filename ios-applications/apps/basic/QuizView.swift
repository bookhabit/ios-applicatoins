//
//  QuizView.swift
//  ios-applications
//
//  Created by 비즈비 on 8/22/25.
//

import SwiftUI

struct QuizView: View {
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var showingResult = false
    
    let questions = [
        QuizQuestion(
            question: "Swift의 개발사는?",
            options: ["Apple", "Google", "Microsoft", "Facebook"],
            correctAnswer: 0
        ),
        QuizQuestion(
            question: "SwiftUI는 언제 출시되었나요?",
            options: ["2014", "2019", "2020", "2021"],
            correctAnswer: 1
        ),
        QuizQuestion(
            question: "iOS의 최신 버전은?",
            options: ["iOS 16", "iOS 17", "iOS 18", "iOS 19"],
            correctAnswer: 2
        )
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if !showingResult {
                    Text("문제 \(currentQuestionIndex + 1)/\(questions.count)")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text(questions[currentQuestionIndex].question)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    VStack(spacing: 12) {
                        ForEach(0..<questions[currentQuestionIndex].options.count, id: \.self) { index in
                            Button(questions[currentQuestionIndex].options[index]) {
                                checkAnswer(index)
                            }
                            .buttonStyle(.bordered)
                            .frame(maxWidth: .infinity)
                        }
                    }
                    
                    Spacer()
                } else {
                    VStack(spacing: 20) {
                        Text("퀴즈 완료!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("점수: \(score)/\(questions.count)")
                            .font(.title)
                        
                        Button("다시 시작") {
                            resetQuiz()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
            .padding()
            .navigationTitle("퀴즈")
        }
    }
    
    private func checkAnswer(_ selectedAnswer: Int) {
        if selectedAnswer == questions[currentQuestionIndex].correctAnswer {
            score += 1
        }
        
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            showingResult = true
        }
    }
    
    private func resetQuiz() {
        currentQuestionIndex = 0
        score = 0
        showingResult = false
    }
}

struct QuizQuestion {
    let question: String
    let options: [String]
    let correctAnswer: Int
}

#Preview {
    QuizView()
}
