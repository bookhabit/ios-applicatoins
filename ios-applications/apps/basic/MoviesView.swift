import SwiftUI

struct MoviesView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "film.fill")
                .font(.system(size: 80))
                .foregroundColor(.pink)
            
            Text("영화 정보")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("영화 정보를 검색하고 저장하는 앱입니다.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            VStack(spacing: 10) {
                Text("인기 영화")
                    .font(.headline)
                
                Text("• 어벤저스: 엔드게임")
                Text("• 스파이더맨: 노 웨이 홈")
                Text("• 토이 스토리 4")
            }
            .padding()
            .background(Color.pink.opacity(0.1))
            .cornerRadius(10)
        }
        .padding()
        .navigationTitle("영화 정보")
    }
}

#Preview {
    NavigationView {
        MoviesView()
    }
}
