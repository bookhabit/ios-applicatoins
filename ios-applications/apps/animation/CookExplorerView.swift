//
//  CookExplorerView.swift
//  ios-applications
//
//  Created by 비즈비 on 8/22/25.
//

import SwiftUI

struct CookExplorerView: View {
    @State private var isAnimating = false
    @State private var selectedRecipe = 0
    
    let recipes = ["파스타", "피자", "샐러드", "스테이크", "수프"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // 요리 애니메이션
                ZStack {
                    // 팬
                    Image(systemName: "circle.fill")
                        .font(.system(size: 120))
                        .foregroundColor(.brown.opacity(0.3))
                        .scaleEffect(isAnimating ? 1.1 : 0.9)
                        .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isAnimating)
                    
                    // 불꽃
                    ForEach(0..<5) { index in
                        Image(systemName: "flame.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.orange)
                            .offset(
                                x: CGFloat(index * 15 - 30),
                                y: 40
                            )
                            .scaleEffect(isAnimating ? 1.3 : 0.7)
                            .animation(
                                .easeInOut(duration: 1.2)
                                .repeatForever(autoreverses: true)
                                .delay(Double(index) * 0.1),
                                value: isAnimating
                            )
                    }
                    
                    // 음식 재료들
                    ForEach(0..<3) { index in
                        Circle()
                            .fill(Color.green.opacity(0.7))
                            .frame(width: 15, height: 15)
                            .offset(
                                x: CGFloat(index * 20 - 20),
                                y: -20
                            )
                            .rotationEffect(.degrees(isAnimating ? 360 : 0))
                            .animation(
                                .linear(duration: 3)
                                .repeatForever(autoreverses: false),
                                value: isAnimating
                            )
                    }
                    
                    // 요리 이름
                    Text(recipes[selectedRecipe])
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(20)
                        .offset(y: 80)
                }
                .frame(height: 300)
                
                // 레시피 선택
                Picker("레시피 선택", selection: $selectedRecipe) {
                    ForEach(0..<recipes.count, id: \.self) { index in
                        Text(recipes[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                // 설명
                Text("요리의 즐거움을 시각화하는 애니메이션입니다.")
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
            .navigationTitle("요리 탐험가")
            .onAppear {
                isAnimating = true
            }
        }
    }
}

#Preview {
    CookExplorerView()
}
