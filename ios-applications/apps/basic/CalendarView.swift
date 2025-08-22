import SwiftUI

struct CalendarView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "calendar")
                .font(.system(size: 80))
                .foregroundColor(.orange)
            
            Text("캘린더")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("일정을 관리하고 계획을 세우는 앱입니다.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            Text("2024년 8월")
                .font(.title2)
                .padding()
                .background(Color.orange.opacity(0.1))
                .cornerRadius(10)
        }
        .padding()
        .navigationTitle("캘린더")
    }
}

#Preview {
    NavigationView {
        CalendarView()
    }
}
