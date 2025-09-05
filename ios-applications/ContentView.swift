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
                    
                    // 폼 예제 앱
                    NavigationLink(destination: FormView()) {
                        AppCardView(
                            title: "폼 예제",
                            description: "다양한 폼 요소들을 사용하는 앱",
                            icon: "doc.text.fill",
                            color: .purple
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 갤러리 앱
                    NavigationLink(destination: GalleryView()) {
                        AppCardView(
                            title: "갤러리",
                            description: "이미지들을 그리드 형태로 표시하는 앱",
                            icon: "photo.on.rectangle",
                            color: .cyan
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 모달 예제 앱
                    NavigationLink(destination: ModalView()) {
                        AppCardView(
                            title: "모달 예제",
                            description: "모달, 알림, 액션시트를 사용하는 앱",
                            icon: "rectangle.3.group.fill",
                            color: .indigo
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 액션 시트 앱
                    NavigationLink(destination: ActionSheetView()) {
                        AppCardView(
                            title: "액션 시트",
                            description: "액션 시트를 사용하는 앱",
                            icon: "list.bullet.rectangle",
                            color: .mint
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 퀴즈 앱
                    NavigationLink(destination: QuizView()) {
                        AppCardView(
                            title: "퀴즈",
                            description: "다양한 퀴즈를 풀어보는 앱",
                            icon: "questionmark.circle.fill",
                            color: .teal
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 상점 앱
                    NavigationLink(destination: ShopView()) {
                        AppCardView(
                            title: "상점",
                            description: "상품을 구매하고 장바구니를 관리하는 앱",
                            icon: "cart.fill",
                            color: .brown
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 걸음 수 카운터 앱
                    NavigationLink(destination: StepCounterView()) {
                        AppCardView(
                            title: "걸음 수 카운터",
                            description: "걸음 수를 추적하고 건강 정보를 관리하는 앱",
                            icon: "figure.walk",
                            color: .green
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 마인드 플로우 앱
                    NavigationLink(destination: MindFlowView()) {
                        AppCardView(
                            title: "마인드 플로우",
                            description: "마음의 흐름을 시각화하는 애니메이션 앱",
                            icon: "brain.head.profile",
                            color: .blue
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 여행의 꿈 앱
                    NavigationLink(destination: TravelDreamsView()) {
                        AppCardView(
                            title: "여행의 꿈",
                            description: "여행의 꿈을 시각화하는 애니메이션 앱",
                            icon: "airplane.circle.fill",
                            color: .cyan
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 요리 탐험가 앱
                    NavigationLink(destination: CookExplorerView()) {
                        AppCardView(
                            title: "요리 탐험가",
                            description: "요리의 즐거움을 시각화하는 애니메이션 앱",
                            icon: "flame.fill",
                            color: .orange
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 돈의 여정 앱
                    NavigationLink(destination: MoneyJourneyView()) {
                        AppCardView(
                            title: "돈의 여정",
                            description: "재정적 성장을 시각화하는 애니메이션 앱",
                            icon: "dollarsign.circle.fill",
                            color: .green
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 퀴즈 히어로 앱
                    NavigationLink(destination: QuizHeroView()) {
                        AppCardView(
                            title: "퀴즈 히어로",
                            description: "퀴즈의 영웅이 되는 여정을 시각화하는 앱",
                            icon: "star.fill",
                            color: .yellow
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 미니 파일 탐색기 앱
                    NavigationLink(destination: MiniFileExplorerView()) {
                        AppCardView(
                            title: "미니 파일 탐색기",
                            description: "파일과 폴더를 탐색하는 앱",
                            icon: "folder.fill",
                            color: .blue
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 보안 노트 앱
                    NavigationLink(destination: SecureNotesView()) {
                        AppCardView(
                            title: "보안 노트",
                            description: "중요한 정보를 안전하게 저장하는 앱",
                            icon: "lock.shield.fill",
                            color: .red
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 심플 상점 앱
                    NavigationLink(destination: SimpleShopView()) {
                        AppCardView(
                            title: "심플 상점",
                            description: "카테고리별 상품을 관리하는 앱",
                            icon: "bag.fill",
                            color: .purple
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 유틸리티 키트 앱
                    NavigationLink(destination: UtilityKitView()) {
                        AppCardView(
                            title: "유틸리티 키트",
                            description: "다양한 유틸리티 도구들을 제공하는 앱",
                            icon: "wrench.and.screwdriver.fill",
                            color: .gray
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 여행 로거 앱
                    NavigationLink(destination: TripLoggerView()) {
                        AppCardView(
                            title: "여행 로거",
                            description: "여행 기록을 관리하는 앱",
                            icon: "airplane.circle",
                            color: .blue
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 미디어 노트 앱
                    NavigationLink(destination: MediaNotesView()) {
                        AppCardView(
                            title: "미디어 노트",
                            description: "영화, 책, 음악 등의 노트를 관리하는 앱",
                            icon: "book.closed.fill",
                            color: .brown
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 미니 건강 추적기 앱
                    NavigationLink(destination: MiniHealthTrackerView()) {
                        AppCardView(
                            title: "미니 건강 추적기",
                            description: "건강 정보를 추적하고 관리하는 앱",
                            icon: "heart.fill",
                            color: .pink
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 센서 놀이터 앱
                    NavigationLink(destination: SensorPlaygroundView()) {
                        AppCardView(
                            title: "센서 놀이터",
                            description: "기기의 센서 데이터를 실시간으로 확인하는 앱",
                            icon: "sensor.tag.radiowaves.forward.fill",
                            color: .green
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 틱택토 게임 앱
                    NavigationLink(destination: TicTacToeView()) {
                        AppCardView(
                            title: "틱택토",
                            description: "클래식한 틱택토 게임을 즐기는 앱",
                            icon: "xmark.circle.fill",
                            color: .blue
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 스네이크 게임 앱
                    NavigationLink(destination: SnakeView()) {
                        AppCardView(
                            title: "스네이크",
                            description: "전통적인 스네이크 게임을 즐기는 앱",
                            icon: "gamecontroller.fill",
                            color: .green
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 메모리 게임 앱
                    NavigationLink(destination: MemoryView()) {
                        AppCardView(
                            title: "메모리 게임",
                            description: "카드 매칭 메모리 게임을 즐기는 앱",
                            icon: "brain.head.profile",
                            color: .purple
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    // SQLite 데이터베이스 앱
                    NavigationLink(destination: SqliteView()) {
                        AppCardView(
                            title: "SQLite 데이터베이스",
                            description: "SQLite를 사용한 사용자 데이터 관리 앱",
                            icon: "server.rack",
                            color: .green
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
