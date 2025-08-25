import SwiftUI

struct ImageDisplayView: View {
    @State private var selectedImageType = "system"
    @State private var selectedImageIndex = 0
    @State private var imageScale: CGFloat = 1.0
    @State private var imageRotation: Double = 0.0
    
    let systemImages = [
        "photo", "camera", "heart.fill", "star.fill", "leaf.fill",
        "flame.fill", "bolt.fill", "drop.fill", "snowflake", "cloud.fill"
    ]
    
    let colors: [Color] = [
        .red, .orange, .yellow, .green, .blue, .purple, .pink
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    Text("이미지 표시")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    // 이미지 타입 선택
                    VStack(alignment: .leading, spacing: 15) {
                        Text("이미지 타입")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Picker("이미지 타입", selection: $selectedImageType) {
                            Text("시스템 이미지").tag("system")
                            Text("색상 이미지").tag("color")
                            Text("그라데이션").tag("gradient")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // 메인 이미지 표시
                    VStack(spacing: 20) {
                        Text("메인 이미지")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Group {
                            switch selectedImageType {
                            case "system":
                                Image(systemName: systemImages[selectedImageIndex])
                                    .font(.system(size: 100))
                                    .foregroundColor(colors[selectedImageIndex % colors.count])
                            case "color":
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(colors[selectedImageIndex % colors.count])
                                    .frame(width: 200, height: 200)
                            case "gradient":
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(
                                        LinearGradient(
                                            colors: [
                                                colors[selectedImageIndex % colors.count],
                                                colors[(selectedImageIndex + 1) % colors.count]
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 200, height: 200)
                            default:
                                Image(systemName: "photo")
                                    .font(.system(size: 100))
                                    .foregroundColor(.gray)
                            }
                        }
                        .scaleEffect(imageScale)
                        .rotationEffect(.degrees(imageRotation))
                        .animation(.easeInOut(duration: 0.3), value: imageScale)
                        .animation(.easeInOut(duration: 0.3), value: imageRotation)
                        
                        // 이미지 제어
                        VStack(spacing: 15) {
                            HStack(spacing: 20) {
                                Button("이전") {
                                    selectedImageIndex = (selectedImageIndex - 1 + systemImages.count) % systemImages.count
                                }
                                .buttonStyle(.bordered)
                                
                                Button("다음") {
                                    selectedImageIndex = (selectedImageIndex + 1) % systemImages.count
                                }
                                .buttonStyle(.bordered)
                            }
                            
                            HStack(spacing: 20) {
                                Button("확대") {
                                    imageScale = min(imageScale + 0.2, 3.0)
                                }
                                .buttonStyle(.bordered)
                                
                                Button("축소") {
                                    imageScale = max(imageScale - 0.2, 0.5)
                                }
                                .buttonStyle(.bordered)
                                
                                Button("회전") {
                                    imageRotation += 90
                                }
                                .buttonStyle(.bordered)
                            }
                            
                            Button("초기화") {
                                imageScale = 1.0
                                imageRotation = 0.0
                            }
                            .buttonStyle(.bordered)
                            .foregroundColor(.red)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // 이미지 갤러리
                    VStack(alignment: .leading, spacing: 15) {
                        Text("이미지 갤러리")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 10) {
                            ForEach(0..<min(8, systemImages.count), id: \.self) { index in
                                Button(action: {
                                    selectedImageIndex = index
                                }) {
                                    if selectedImageType == "system" {
                                        Image(systemName: systemImages[index])
                                            .font(.system(size: 30))
                                            .foregroundColor(colors[index % colors.count])
                                            .frame(width: 60, height: 60)
                                            .background(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(selectedImageIndex == index ? Color.blue.opacity(0.3) : Color(.systemGray5))
                                            )
                                    } else {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(colors[index % colors.count])
                                            .frame(width: 60, height: 60)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(selectedImageIndex == index ? Color.blue : Color.clear, lineWidth: 3)
                                            )
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // 이미지 정보
                    VStack(alignment: .leading, spacing: 15) {
                        Text("이미지 정보")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("타입: \(selectedImageType)")
                            Text("인덱스: \(selectedImageIndex)")
                            Text("크기: \(String(format: "%.1f", imageScale))x")
                            Text("회전: \(Int(imageRotation))°")
                        }
                        .font(.body)
                        .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .padding()
            }
            .navigationTitle("이미지 표시")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ImageDisplayView()
}
