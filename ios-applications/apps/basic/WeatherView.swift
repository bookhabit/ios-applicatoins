import SwiftUI

struct WeatherView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "cloud.sun.fill")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            Text("날씨 확인")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("현재 날씨 정보를 확인하는 앱입니다.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            Text("서울: 맑음 23°C")
                .font(.title2)
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)
        }
        .padding()
        .navigationTitle("날씨 확인")
    }
}

#Preview {
    NavigationView {
        WeatherView()
    }
}
