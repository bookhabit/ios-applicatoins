//
//  MiniHealthTrackerView.swift
//  ios-applications
//
//  Created by 비즈비 on 8/22/25.
//

import SwiftUI

struct MiniHealthTrackerView: View {
    @State private var waterIntake = 0
    @State private var sleepHours = 7.5
    @State private var mood = "보통"
    @State private var exerciseMinutes = 30
    
    let moods = ["매우 나쁨", "나쁨", "보통", "좋음", "매우 좋음"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // 물 섭취량
                    HealthCard(
                        title: "물 섭취량",
                        icon: "drop.fill",
                        color: .blue,
                        value: "\(waterIntake)잔",
                        subtitle: "목표: 8잔"
                    ) {
                        HStack(spacing: 20) {
                            Button("-") {
                                if waterIntake > 0 {
                                    waterIntake -= 1
                                }
                            }
                            .buttonStyle(.bordered)
                            .font(.title2)
                            
                            Button("+") {
                                waterIntake += 1
                            }
                            .buttonStyle(.borderedProminent)
                            .font(.title2)
                        }
                    }
                    
                    // 수면 시간
                    HealthCard(
                        title: "수면 시간",
                        icon: "bed.double.fill",
                        color: .purple,
                        value: String(format: "%.1f시간", sleepHours),
                        subtitle: "권장: 7-9시간"
                    ) {
                        Slider(value: $sleepHours, in: 0...12, step: 0.5)
                            .accentColor(.purple)
                    }
                    
                    // 기분
                    HealthCard(
                        title: "오늘 기분",
                        icon: "face.smiling",
                        color: .yellow,
                        value: mood,
                        subtitle: "기분을 기록해보세요"
                    ) {
                        Picker("기분", selection: $mood) {
                            ForEach(moods, id: \.self) { mood in
                                Text(mood).tag(mood)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    // 운동 시간
                    HealthCard(
                        title: "운동 시간",
                        icon: "figure.run",
                        color: .green,
                        value: "\(exerciseMinutes)분",
                        subtitle: "목표: 30분"
                    ) {
                        HStack(spacing: 20) {
                            Button("-5분") {
                                if exerciseMinutes >= 5 {
                                    exerciseMinutes -= 5
                                }
                            }
                            .buttonStyle(.bordered)
                            
                            Button("+5분") {
                                exerciseMinutes += 5
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                    
                    // 요약
                    VStack(spacing: 16) {
                        Text("오늘의 요약")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        HStack {
                            SummaryItem(title: "물", value: "\(waterIntake)/8", color: .blue)
                            SummaryItem(title: "수면", value: String(format: "%.1f", sleepHours), color: .purple)
                            SummaryItem(title: "운동", value: "\(exerciseMinutes)분", color: .green)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(16)
                }
                .padding()
            }
            .navigationTitle("미니 건강 추적기")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("초기화") {
                        waterIntake = 0
                        sleepHours = 7.5
                        mood = "보통"
                        exerciseMinutes = 30
                    }
                }
            }
        }
    }
}

struct HealthCard<Content: View>: View {
    let title: String
    let icon: String
    let color: Color
    let value: String
    let subtitle: String
    let content: Content
    
    init(title: String, icon: String, color: Color, value: String, subtitle: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.color = color
        self.value = value
        self.subtitle = subtitle
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                    
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(color)
            }
            
            content
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(16)
    }
}

struct SummaryItem: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(color)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    MiniHealthTrackerView()
}
