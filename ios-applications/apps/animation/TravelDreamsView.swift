//
//  TravelDreamsView.swift
//  ios-applications
//
//  Created by 비즈비 on 8/22/25.
//

import SwiftUI

struct TravelDreamsView: View {
    @State private var isAnimating = false
    @State private var selectedDestination = 0
    
    let destinations = ["파리", "도쿄", "뉴욕", "로마", "시드니"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // 여행 애니메이션
                ZStack {
                    // 배경
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(
                                colors: [.blue.opacity(0.3), .green.opacity(0.3)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 250)
                    
                    // 비행기
                    Image(systemName: "airplane")
                        .font(.system(size: 40))
                        .foregroundColor(.blue)
                        .offset(x: isAnimating ? 120 : -120, y: -20)
                        .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: isAnimating)
                    
                    // 구름들
                    ForEach(0..<3) { index in
                        Image(systemName: "cloud.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white.opacity(0.8))
                            .offset(
                                x: isAnimating ? 100 : -100,
                                y: CGFloat(index * 30 - 30)
                            )
                            .animation(
                                .easeInOut(duration: 4)
                                .repeatForever(autoreverses: true)
                                .delay(Double(index) * 0.5),
                                value: isAnimating
                            )
                    }
                    
                    // 목적지 표시
                    VStack {
                        Image(systemName: "mappin.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.red)
                            .scaleEffect(isAnimating ? 1.2 : 0.8)
                            .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: isAnimating)
                        
                        Text(destinations[selectedDestination])
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .offset(x: 80, y: 40)
                }
                
                // 목적지 선택
                Picker("목적지 선택", selection: $selectedDestination) {
                    ForEach(0..<destinations.count, id: \.self) { index in
                        Text(destinations[index]).tag(index)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 100)
                
                // 설명
                Text("여행의 꿈을 시각화하는 애니메이션입니다.")
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
            .navigationTitle("여행의 꿈")
            .onAppear {
                isAnimating = true
            }
        }
    }
}

#Preview {
    TravelDreamsView()
}
