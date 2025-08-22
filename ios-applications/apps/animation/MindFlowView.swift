//
//  MindFlowView.swift
//  ios-applications
//
//  Created by 비즈비 on 8/22/25.
//

import SwiftUI

struct MindFlowView: View {
    @State private var isAnimating = false
    @State private var selectedFlow = 0
    
    let flows = ["생각 흐름", "아이디어", "창의성", "집중력"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // 메인 애니메이션
                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [.blue.opacity(0.3), .purple.opacity(0.1)],
                                center: .center,
                                startRadius: 50,
                                endRadius: 150
                            )
                        )
                        .scaleEffect(isAnimating ? 1.2 : 0.8)
                        .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isAnimating)
                    
                    ForEach(0..<6) { index in
                        Circle()
                            .fill(Color.blue.opacity(0.6))
                            .frame(width: 20, height: 20)
                            .offset(
                                x: cos(Double(index) * .pi / 3) * 80,
                                y: sin(Double(index) * .pi / 3) * 80
                            )
                            .scaleEffect(isAnimating ? 1.5 : 0.5)
                            .animation(
                                .easeInOut(duration: 1.5)
                                .repeatForever(autoreverses: true)
                                .delay(Double(index) * 0.2),
                                value: isAnimating
                            )
                    }
                }
                .frame(height: 300)
                
                // 플로우 선택
                Picker("플로우 선택", selection: $selectedFlow) {
                    ForEach(0..<flows.count, id: \.self) { index in
                        Text(flows[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                // 설명
                Text(flows[selectedFlow])
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("마음의 흐름을 시각화하고 집중력을 향상시키는 애니메이션입니다.")
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
            .navigationTitle("마인드 플로우")
            .onAppear {
                isAnimating = true
            }
        }
    }
}

#Preview {
    MindFlowView()
}
