//
//  QuizHeroView.swift
//  ios-applications
//
//  Created by 비즈비 on 8/22/25.
//

import SwiftUI

struct QuizHeroView: View {
    @State private var isAnimating = false
    @State private var selectedCategory = 0
    
    let categories = ["수학", "과학", "역사", "문학", "지리"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // 퀴즈 히어로 애니메이션
                ZStack {
                    // 배경
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(
                                colors: [.purple.opacity(0.3), .blue.opacity(0.3)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 250)
                    
                    // 퀴즈 아이콘들
                    ForEach(0..<6) { index in
                        Image(systemName: "questionmark.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .offset(
                                x: cos(Double(index) * .pi / 3) * 70,
                                y: sin(Double(index) * .pi / 3) * 70
                            )
                            .scaleEffect(isAnimating ? 1.2 : 0.8)
                            .animation(
                                .easeInOut(duration: 1.8)
                                .repeatForever(autoreverses: true)
                                .delay(Double(index) * 0.2),
                                value: isAnimating
                            )
                    }
                    
                    // 중앙 히어로
                    VStack {
                        Image(systemName: "brain.head.profile")
                            .font(.system(size: 60))
                            .foregroundColor(.yellow)
                            .scaleEffect(isAnimating ? 1.1 : 0.9)
                            .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isAnimating)
                        
                        Text("퀴즈 히어로")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    
                    // 별들
                    ForEach(0..<4) { index in
                        Image(systemName: "star.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.yellow)
                            .offset(
                                x: CGFloat(index * 40 - 60),
                                y: -80
                            )
                            .rotationEffect(.degrees(isAnimating ? 360 : 0))
                            .animation(
                                .linear(duration: 3)
                                .repeatForever(autoreverses: false)
                                .delay(Double(index) * 0.3),
                                value: isAnimating
                            )
                    }
                }
                
                // 카테고리 선택
                Picker("카테고리 선택", selection: $selectedCategory) {
                    ForEach(0..<categories.count, id: \.self) { index in
                        Text(categories[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                // 설명
                Text("퀴즈의 영웅이 되는 여정을 시각화하는 애니메이션입니다.")
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
            .navigationTitle("퀴즈 히어로")
            .onAppear {
                isAnimating = true
            }
        }
    }
}

#Preview {
    QuizHeroView()
}
