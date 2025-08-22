//
//  ContentView.swift
//  ios-applications
//
//  Created by 비즈비 on 8/22/25.
//

import SwiftUI



struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 20) {
                    // 할 일 관리 앱
                    NavigationLink(destination: TodoView()) {
                        AppCardView(
                            title: "할 일 관리",
                            description: "할 일을 관리하고 완료 상태를 추적하는 앱",
                            icon: "checkmark.circle.fill",
                            color: .green
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 날씨 확인 앱
                    NavigationLink(destination: WeatherView()) {
                        AppCardView(
                            title: "날씨 확인",
                            description: "현재 날씨 정보를 확인하는 앱",
                            icon: "cloud.sun.fill",
                            color: .blue
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 메모 작성 앱
                    NavigationLink(destination: NotesView()) {
                        AppCardView(
                            title: "메모 작성",
                            description: "간단한 메모를 작성하고 저장하는 앱",
                            icon: "note.text",
                            color: .orange
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 영화 정보 앱
                    NavigationLink(destination: MoviesView()) {
                        AppCardView(
                            title: "영화 정보",
                            description: "영화 정보를 검색하고 저장하는 앱",
                            icon: "film.fill",
                            color: .pink
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 캘린더 앱
                    NavigationLink(destination: CalendarView()) {
                        AppCardView(
                            title: "캘린더",
                            description: "일정을 관리하고 계획을 세우는 앱",
                            icon: "calendar",
                            color: .orange
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding()
            }
            .navigationTitle("앱 모음")
        }
    }
}



struct AppCardView: View {
    let title: String
    let description: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 40))
                .foregroundColor(color)
            
            VStack(spacing: 8) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
            }
        }
        .frame(height: 160)
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray.opacity(0.1))                            
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    ContentView()
}
