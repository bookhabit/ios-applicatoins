//
//  ContentView.swift
//  ios-applications
//
//  Created by 비즈비 on 8/22/25.
//

import SwiftUI



struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // 메인 앱 목록
            NavigationView {
                ScrollView {
                    VStack(spacing: 30) {
                        // 헤더
                        VStack(alignment: .leading, spacing: 8) {
                            Text("앱 모음")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            Text("다양한 기능의 앱들을 체험해보세요")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    // Basic Apps 섹션
                    VStack(alignment: .leading, spacing: 20) {
                        Text("기본 앱")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
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
                            
                            // 계산기 앱
                            NavigationLink(destination: CalculatorView()) {
                                AppCardView(
                                    title: "계산기",
                                    description: "기본적인 수학 계산을 수행하는 앱",
                                    icon: "plus.forwardslash.minus",
                                    color: .indigo
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            // 이벤트 테스트 앱
                            NavigationLink(destination: EventTestView()) {
                                AppCardView(
                                    title: "이벤트 테스트",
                                    description: "다양한 이벤트 처리를 테스트하는 앱",
                                    icon: "hand.tap.fill",
                                    color: .teal
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            // 그래픽 그리기 앱
                            NavigationLink(destination: GraphicsDrawingView()) {
                                AppCardView(
                                    title: "그래픽 그리기",
                                    description: "Canvas와 Paint로 그래픽을 그리는 앱",
                                    icon: "paintbrush.fill",
                                    color: .purple
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            // 이미지 표시 앱
                            NavigationLink(destination: ImageDisplayView()) {
                                AppCardView(
                                    title: "이미지 표시",
                                    description: "다양한 이미지 표시 방법을 테스트하는 앱",
                                    icon: "photo.fill",
                                    color: .cyan
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            // 대화상자 & 팝업 & 알림 앱
                            NavigationLink(destination: DialogPopupNotificationView()) {
                                AppCardView(
                                    title: "대화상자 & 팝업 & 알림",
                                    description: "다양한 대화상자, 팝업, 알림을 테스트하는 앱",
                                    icon: "bell.fill",
                                    color: .red
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            // 리스트 뷰 앱
                            NavigationLink(destination: ListView()) {
                                AppCardView(
                                    title: "리스트 뷰",
                                    description: "ListView, RecyclerView, Spinner 등 다양한 리스트 기술을 학습하는 앱",
                                    icon: "list.bullet",
                                    color: .blue
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
                        .padding(.horizontal)
                    }
                    
                    // Game Apps 섹션
                    VStack(alignment: .leading, spacing: 20) {
                        Text("게임")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 20) {
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
                        }
                        .padding(.horizontal)
                    }
                    
                    // Animation Apps 섹션
                    VStack(alignment: .leading, spacing: 20) {
                        Text("애니메이션")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 20) {
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
                        }
                        .padding(.horizontal)
                    }
                    
                    // Native Apps 섹션
                    VStack(alignment: .leading, spacing: 20) {
                        Text("네이티브")
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 20) {
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
                        }
                        .padding(.horizontal)
                    }
                    }
                    .padding(.vertical)
                }
                .navigationTitle("앱 모음")
                .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("홈")
            }
            .tag(0)
            
            // 즐겨찾기 탭
            NavigationView {
                FavoritesView()
            }
            .tabItem {
                Image(systemName: "heart.fill")
                Text("즐겨찾기")
            }
            .tag(1)
            
            // 카테고리 탭
            NavigationView {
                CategoriesView()
            }
            .tabItem {
                Image(systemName: "square.grid.2x2.fill")
                Text("카테고리")
            }
            .tag(2)
            
            // 설정 탭
            NavigationView {
                SettingsView()
            }
            .tabItem {
                Image(systemName: "gearshape.fill")
                Text("설정")
            }
            .tag(3)
        }
        .accentColor(.blue)
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

// MARK: - 즐겨찾기 뷰
struct FavoritesView: View {
    @State private var favoriteApps: [String] = ["할 일 관리", "계산기", "메모 작성"]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("즐겨찾기")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            if favoriteApps.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "heart")
                        .font(.system(size: 48))
                        .foregroundColor(.gray)
                    
                    Text("즐겨찾기한 앱이 없습니다")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    Text("앱을 즐겨찾기에 추가해보세요")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 60)
            } else {
                LazyVStack(spacing: 12) {
                    ForEach(favoriteApps, id: \.self) { appName in
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            
                            Text(appName)
                                .font(.headline)
                            
                            Spacer()
                            
                            Button(action: {
                                removeFavorite(appName)
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
            }
            
            Spacer()
        }
        .navigationTitle("즐겨찾기")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func removeFavorite(_ appName: String) {
        favoriteApps.removeAll { $0 == appName }
    }
}

// MARK: - 카테고리 뷰
struct CategoriesView: View {
    let categories = [
        ("기본 앱", "apps.iphone", Color.blue, ["할 일 관리", "계산기", "메모 작성", "날씨 확인"]),
        ("게임", "gamecontroller.fill", Color.green, ["틱택토", "스네이크", "메모리 게임"]),
        ("애니메이션", "sparkles", Color.purple, ["마인드 플로우", "여행의 꿈", "요리 탐험가"]),
        ("네이티브", "iphone", Color.orange, ["미니 파일 탐색기", "보안 노트", "센서 놀이터"])
    ]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(categories, id: \.0) { category in
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: category.1)
                                .foregroundColor(category.2)
                                .font(.title2)
                            
                            Text(category.0)
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Text("\(category.3.count)개")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(category.2.opacity(0.2))
                                .cornerRadius(8)
                        }
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 8) {
                            ForEach(category.3, id: \.self) { app in
                                Text(app)
                                    .font(.caption)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(category.2.opacity(0.1))
                                    .cornerRadius(6)
                            }
                        }
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                }
            }
            .padding()
        }
        .navigationTitle("카테고리")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - 설정 뷰
struct SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var darkModeEnabled = false
    @State private var hapticFeedbackEnabled = true
    
    var body: some View {
        List {
            Section("앱 설정") {
                HStack {
                    Image(systemName: "bell.fill")
                        .foregroundColor(.blue)
                        .frame(width: 24)
                    
                    Text("알림")
                    
                    Spacer()
                    
                    Toggle("", isOn: $notificationsEnabled)
                }
                
                HStack {
                    Image(systemName: "moon.fill")
                        .foregroundColor(.purple)
                        .frame(width: 24)
                    
                    Text("다크 모드")
                    
                    Spacer()
                    
                    Toggle("", isOn: $darkModeEnabled)
                }
                
                HStack {
                    Image(systemName: "iphone.radiowaves.left.and.right")
                        .foregroundColor(.green)
                        .frame(width: 24)
                    
                    Text("햅틱 피드백")
                    
                    Spacer()
                    
                    Toggle("", isOn: $hapticFeedbackEnabled)
                }
            }
            
            Section("정보") {
                HStack {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(.blue)
                        .frame(width: 24)
                    
                    Text("앱 버전")
                    
                    Spacer()
                    
                    Text("1.0.0")
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Image(systemName: "person.circle.fill")
                        .foregroundColor(.green)
                        .frame(width: 24)
                    
                    Text("개발자")
                    
                    Spacer()
                    
                    Text("비즈비")
                        .foregroundColor(.secondary)
                }
            }
            
            Section("지원") {
                Button(action: {
                    // 피드백 액션
                }) {
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.blue)
                            .frame(width: 24)
                        
                        Text("피드백 보내기")
                    }
                }
                
                Button(action: {
                    // 도움말 액션
                }) {
                    HStack {
                        Image(systemName: "questionmark.circle.fill")
                            .foregroundColor(.orange)
                            .frame(width: 24)
                        
                        Text("도움말")
                    }
                }
            }
        }
        .navigationTitle("설정")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContentView()
}
