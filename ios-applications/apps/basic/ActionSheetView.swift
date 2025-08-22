//
//  ActionSheetView.swift
//  ios-applications
//
//  Created by 비즈비 on 8/22/25.
//

import SwiftUI

struct ActionSheetView: View {
    @State private var showingActionSheet = false
    @State private var selectedOption = "선택되지 않음"
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("선택된 옵션: \(selectedOption)")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                
                Button("액션 시트 표시") {
                    showingActionSheet = true
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
            .padding()
            .navigationTitle("액션 시트")
            .confirmationDialog("옵션 선택", isPresented: $showingActionSheet, titleVisibility: .visible) {
                Button("옵션 1") {
                    selectedOption = "옵션 1"
                }
                
                Button("옵션 2") {
                    selectedOption = "옵션 2"
                }
                
                Button("옵션 3") {
                    selectedOption = "옵션 3"
                }
                
                Button("취소", role: .cancel) { }
            } message: {
                Text("원하는 옵션을 선택하세요.")
            }
        }
    }
}

#Preview {
    ActionSheetView()
}
