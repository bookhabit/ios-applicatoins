//
//  MoneyJourneyView.swift
//  ios-applications
//
//  Created by 비즈비 on 8/22/25.
//

import SwiftUI

struct MoneyJourneyView: View {
    @State private var isAnimating = false
    @State private var selectedGoal = 0
    
    let goals = ["저축", "투자", "경제적 자유", "은퇴 계획", "비즈니스"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // 돈 애니메이션
                ZStack {
                    // 동전들
                    ForEach(0..<8) { index in
                        Image(systemName: "circle.fill")
                            .font(.system(size: 25))
                            .foregroundColor(.yellow)
                            .offset(
                                x: cos(Double(index) * .pi / 4) * 80,
                                y: sin(Double(index) * .pi / 4) * 80
                            )
                            .rotationEffect(.degrees(isAnimating ? 360 : 0))
                            .animation(
                                .linear(duration: 4)
                                .repeatForever(autoreverses: false)
                                .delay(Double(index) * 0.1),
                                value: isAnimating
                            )
                    }
                    
                    // 중앙 동전
                    Image(systemName: "dollarsign.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.green)
                        .scaleEffect(isAnimating ? 1.3 : 0.7)
                        .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isAnimating)
                    
                    // 성장 그래프
                    Path { path in
                        path.move(to: CGPoint(x: -60, y: 40))
                        path.addLine(to: CGPoint(x: -20, y: 20))
                        path.addLine(to: CGPoint(x: 20, y: -20))
                        path.addLine(to: CGPoint(x: 60, y: -40))
                    }
                    .stroke(Color.green, lineWidth: 3)
                    .scaleEffect(isAnimating ? 1.1 : 0.9)
                    .animation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true), value: isAnimating)
                }
                .frame(height: 300)
                
                // 목표 선택
                Picker("목표 선택", selection: $selectedGoal) {
                    ForEach(0..<goals.count, id: \.self) { index in
                        Text(goals[index]).tag(index)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 100)
                
                // 설명
                Text("재정적 성장을 시각화하는 애니메이션입니다.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                // 컨트롤
                Button(isAnimating ? "애니메이션 중지" : "애니메이션 시작") {
                    isAnimating.toggle()
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
            .padding()
            .navigationTitle("돈의 여정")
            .onAppear {
                isAnimating = true
            }
        }
    }
}

#Preview {
    MoneyJourneyView()
}
