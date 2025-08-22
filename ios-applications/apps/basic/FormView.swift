//
//  FormView.swift
//  ios-applications
//
//  Created by 비즈비 on 8/22/25.
//

import SwiftUI

struct FormView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var age = ""
    @State private var isSubscribed = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("개인 정보")) {
                    TextField("이름", text: $name)
                    TextField("이메일", text: $email)
                        .keyboardType(.emailAddress)
                    TextField("나이", text: $age)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("설정")) {
                    Toggle("뉴스레터 구독", isOn: $isSubscribed)
                }
                
                Section {
                    Button("제출") {
                        // 폼 제출 로직
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                }
            }
            .navigationTitle("폼 예제")
        }
    }
}

#Preview {
    FormView()
}
