//
//  StepCounterView.swift
//  ios-applications
//
//  Created by 비즈비 on 8/22/25.
//

import SwiftUI

struct StepCounterView: View {
    @State private var stepCount = 0
    @State private var goalSteps = 10000
    @State private var showingGoalSetting = false
    
    var progress: Double {
        Double(stepCount) / Double(goalSteps)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // 걸음 수 표시
                VStack(spacing: 16) {
                    Text("\(stepCount)")
                        .font(.system(size: 72, weight: .bold, design: .rounded))
                        .foregroundColor(.green)
                    
                    Text("걸음")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                
                // 진행률 바
                VStack(spacing: 8) {
                    ProgressView(value: progress, total: 1.0)
                        .progressViewStyle(LinearProgressViewStyle(tint: .green))
                        .scaleEffect(x: 1, y: 2, anchor: .center)
                    
                    Text("목표: \(goalSteps)걸음")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                
                // 컨트롤 버튼
                HStack(spacing: 20) {
                    Button("걸음 추가") {
                        stepCount += 100
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button("초기화") {
                        stepCount = 0
                    }
                    .buttonStyle(.bordered)
                }
                
                // 통계
                VStack(spacing: 16) {
                    HStack {
                                 StatCard(title: "거리", value: String(format: "%.1f km", Double(stepCount) * 0.0008))

                        StatCard(title: "칼로리", value: "\(stepCount / 20)kcal")
                    }
                    
                    HStack {
                        StatCard(title: "시간", value: "\(stepCount / 100)분")
                        StatCard(title: "단계", value: "\(stepCount / 1000)층")
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("걸음 수 카운터")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("목표 설정") {
                        showingGoalSetting = true
                    }
                }
            }
            .alert("목표 걸음 수 설정", isPresented: $showingGoalSetting) {
                TextField("목표 걸음 수", value: $goalSteps, format: .number)
                    .keyboardType(.numberPad)
                Button("확인") { }
                Button("취소", role: .cancel) { }
            } message: {
                Text("새로운 목표 걸음 수를 입력하세요.")
            }
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.headline)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    StepCounterView()
}
