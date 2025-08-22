//
//  ModalView.swift
//  ios-applications
//
//  Created by 비즈비 on 8/22/25.
//

import SwiftUI

struct ModalView: View {
    @State private var showingModal = false
    @State private var showingAlert = false
    @State private var showingActionSheet = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Button("모달 표시") {
                    showingModal = true
                }
                .buttonStyle(.borderedProminent)
                
                Button("알림 표시") {
                    showingAlert = true
                }
                .buttonStyle(.bordered)
                
                Button("액션 시트 표시") {
                    showingActionSheet = true
                }
                .buttonStyle(.bordered)
            }
            .padding()
            .navigationTitle("모달 예제")
            .sheet(isPresented: $showingModal) {
                ModalSheetView()
            }
            .alert("알림", isPresented: $showingAlert) {
                Button("확인") { }
            } message: {
                Text("이것은 알림 메시지입니다.")
            }
            .confirmationDialog("액션 선택", isPresented: $showingActionSheet, titleVisibility: .visible) {
                Button("옵션 1") { }
                Button("옵션 2") { }
                Button("취소", role: .cancel) { }
            }
        }
    }
}

struct ModalSheetView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Text("모달 내용")
                    .font(.title)
                    .padding()
                
                Button("닫기") {
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("모달")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("닫기") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ModalView()
}
