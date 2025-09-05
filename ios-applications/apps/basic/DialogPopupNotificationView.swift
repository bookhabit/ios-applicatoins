import SwiftUI

struct DialogPopupNotificationView: View {
    @State private var showBasicAlert = false
    @State private var showConfirmDialog = false
    @State private var showInputDialog = false
    @State private var showCustomModal = false
    @State private var showActionSheet = false
    @State private var inputText = ""
    @State private var alertResult = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    Text("대화상자 & 팝업 & 알림")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    // 기본 알림
                    VStack(alignment: .leading, spacing: 15) {
                        Text("기본 알림")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Button("알림 표시") {
                            showBasicAlert = true
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // 확인 다이얼로그
                    VStack(alignment: .leading, spacing: 15) {
                        Text("확인 다이얼로그")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Button("확인 다이얼로그") {
                            showConfirmDialog = true
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // 입력 다이얼로그
                    VStack(alignment: .leading, spacing: 15) {
                        Text("입력 다이얼로그")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Button("입력 다이얼로그") {
                            showInputDialog = true
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // 커스텀 모달
                    VStack(alignment: .leading, spacing: 15) {
                        Text("커스텀 모달")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Button("모달 열기") {
                            showCustomModal = true
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // 액션 시트
                    VStack(alignment: .leading, spacing: 15) {
                        Text("액션 시트")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Button("액션 시트 열기") {
                            showActionSheet = true
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // 결과 표시
                    if !alertResult.isEmpty {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("알림 결과")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text(alertResult)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                }
                .padding()
            }
            .navigationTitle("대화상자 & 팝업 & 알림")
            .navigationBarTitleDisplayMode(.inline)
            
            // 기본 알림
            .alert("알림", isPresented: $showBasicAlert) {
                Button("확인") { }
            } message: {
                Text("이것은 기본 알림입니다!")
            }
            
            // 확인 다이얼로그
            .alert("확인", isPresented: $showConfirmDialog) {
                Button("취소", role: .cancel) { }
                Button("확인") {
                    alertResult = "사용자가 확인했습니다."
                }
            } message: {
                Text("정말로 진행하시겠습니까?")
            }
            
            // 입력 다이얼로그
            .alert("입력", isPresented: $showInputDialog) {
                TextField("이름을 입력하세요", text: $inputText)
                Button("취소", role: .cancel) { }
                Button("확인") {
                    alertResult = "입력된 이름: \(inputText)"
                    inputText = ""
                }
            }
            
            // 커스텀 모달
            .sheet(isPresented: $showCustomModal) {
                CustomModalView(isPresented: $showCustomModal)
            }
            
            // 액션 시트
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(
                    title: Text("액션 선택"),
                    buttons: [
                        .default(Text("사진 촬영")) {
                            alertResult = "사진 촬영을 선택했습니다."
                        },
                        .default(Text("갤러리에서 선택")) {
                            alertResult = "갤러리에서 선택을 선택했습니다."
                        },
                        .cancel()
                    ]
                )
            }
        }
    }
}

struct CustomModalView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "star.fill")
                    .font(.system(size: 64))
                    .foregroundColor(.yellow)
                
                Text("커스텀 모달")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("이것은 커스텀 스타일을 가진 모달입니다.")
                    .multilineTextAlignment(.center)
                
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Text("사용자 정의 아이콘")
                }
                
                Button("닫기") {
                    isPresented = false
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("커스텀 모달")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("닫기") {
                isPresented = false
            })
        }
    }
}

#Preview {
    DialogPopupNotificationView()
}
