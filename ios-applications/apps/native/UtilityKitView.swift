//
//  UtilityKitView.swift
//  ios-applications
//
//  Created by 비즈비 on 8/22/25.
//

import SwiftUI

struct UtilityKitView: View {
    @State private var selectedTool = 0
    
    let tools = [
        UtilityTool(name: "QR 코드 스캐너", icon: "qrcode.viewfinder", description: "QR 코드를 스캔하여 정보를 확인합니다"),
        UtilityTool(name: "바코드 스캐너", icon: "barcode.viewfinder", description: "바코드를 스캔하여 상품 정보를 확인합니다"),
        UtilityTool(name: "색상 선택기", icon: "eyedropper", description: "화면에서 색상을 선택하고 색상 코드를 확인합니다"),
        UtilityTool(name: "단위 변환기", icon: "arrow.left.arrow.right", description: "길이, 무게, 온도 등을 변환합니다"),
        UtilityTool(name: "계산기", icon: "plus.forwardslash.minus", description: "간단한 계산을 수행합니다"),
        UtilityTool(name: "타이머", icon: "timer", description: "시간을 측정하고 알림을 설정합니다")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                // 선택된 도구 표시
                if selectedTool < tools.count {
                    VStack(spacing: 20) {
                        Image(systemName: tools[selectedTool].icon)
                            .font(.system(size: 80))
                            .foregroundColor(.blue)
                        
                        Text(tools[selectedTool].name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(tools[selectedTool].description)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        // 도구별 기능 버튼
                        Button("사용하기") {
                            // 도구별 기능 실행
                        }
                        .buttonStyle(.borderedProminent)
                        .font(.title3)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(20)
                    .padding()
                }
                
                // 도구 목록
                List(tools.indices, id: \.self) { index in
                    HStack {
                        Image(systemName: tools[index].icon)
                            .font(.title2)
                            .foregroundColor(.blue)
                            .frame(width: 40)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(tools[index].name)
                                .font(.headline)
                            
                            Text(tools[index].description)
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                        }
                        
                        Spacer()
                        
                        if selectedTool == index {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedTool = index
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("유틸리티 키트")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("설정") {
                        // 설정 화면
                    }
                }
            }
        }
    }
}

struct UtilityTool {
    let name: String
    let icon: String
    let description: String
}

#Preview {
    UtilityKitView()
}
