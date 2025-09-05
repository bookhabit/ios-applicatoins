import SwiftUI

struct EventTestView: View {
    @State private var touchCount = 0
    @State private var longPressCount = 0
    @State private var swipeCount = 0
    @State private var pinchCount = 0
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    Text("이벤트 테스트")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    // 터치 이벤트
                    VStack(alignment: .leading, spacing: 15) {
                        Text("터치 이벤트")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Button(action: {
                            touchCount += 1
                        }) {
                            Text("터치하거나 길게 누르세요")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        .onLongPressGesture {
                            longPressCount += 1
                            alertMessage = "Long press detected!"
                            showAlert = true
                        }
                        
                        Text("터치 횟수: \(touchCount)")
                        Text("길게 누르기 횟수: \(longPressCount)")
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // 스와이프 제스처
                    VStack(alignment: .leading, spacing: 15) {
                        Text("스와이프 제스처")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("좌우로 스와이프하세요")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(8)
                            .gesture(
                                DragGesture()
                                    .onEnded { value in
                                        if abs(value.translation.width) > 50 {
                                            swipeCount += 1
                                        }
                                    }
                            )
                        
                        Text("스와이프 횟수: \(swipeCount)")
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // 핀치 제스처
                    VStack(alignment: .leading, spacing: 15) {
                        Text("핀치 제스처")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("핀치 제스처를 해보세요")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .cornerRadius(8)
                            .scaleEffect(1.0)
                            .gesture(
                                MagnificationGesture()
                                    .onChanged { _ in
                                        // 핀치 제스처 감지
                                    }
                                    .onEnded { _ in
                                        pinchCount += 1
                                    }
                            )
                        
                        Text("핀치 횟수: \(pinchCount)")
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // 알림 테스트
                    VStack(alignment: .leading, spacing: 15) {
                        Text("알림 테스트")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Button("알림 표시") {
                            alertMessage = "이것은 테스트 알림입니다!"
                            showAlert = true
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button("확인 다이얼로그") {
                            alertMessage = "사용자가 확인했습니다."
                            showAlert = true
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // 카운터 초기화
                    Button("카운터 초기화") {
                        touchCount = 0
                        longPressCount = 0
                        swipeCount = 0
                        pinchCount = 0
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(.red)
                }
                .padding()
            }
            .navigationTitle("이벤트 테스트")
            .navigationBarTitleDisplayMode(.inline)
            .alert("알림", isPresented: $showAlert) {
                Button("확인") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
}

#Preview {
    EventTestView()
}
