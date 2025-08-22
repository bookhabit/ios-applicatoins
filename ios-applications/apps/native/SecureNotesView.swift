//
//  SecureNotesView.swift
//  ios-applications
//
//  Created by 비즈비 on 8/22/25.
//

import SwiftUI

struct SecureNotesView: View {
    @State private var notes: [SecureNote] = [
        SecureNote(title: "개인 비밀번호", content: "은행: 1234, 카드: 5678", isLocked: true),
        SecureNote(title: "회사 계정", content: "이메일: user@company.com", isLocked: false),
        SecureNote(title: "의료 정보", content: "혈액형: A+, 알레르기: 없음", isLocked: true),
        SecureNote(title: "여행 계획", content: "도쿄 여행 2024년 3월", isLocked: false)
    ]
    @State private var showingAddNote = false
    @State private var searchText = ""
    
    var filteredNotes: [SecureNote] {
        if searchText.isEmpty {
            return notes
        } else {
            return notes.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // 검색바
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    
                    TextField("노트 검색", text: $searchText)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
                
                // 노트 목록
                List(filteredNotes) { note in
                    HStack {
                        Image(systemName: note.isLocked ? "lock.fill" : "lock.open.fill")
                            .foregroundColor(note.isLocked ? .red : .green)
                            .frame(width: 30)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(note.title)
                                .font(.headline)
                            
                            Text(note.content)
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                        }
                        
                        Spacer()
                        
                        Button(note.isLocked ? "잠금 해제" : "잠금") {
                            toggleLock(for: note)
                        }
                        .buttonStyle(.bordered)
                        .font(.caption)
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("보안 노트")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("새 노트") {
                        showingAddNote = true
                    }
                }
            }
            .sheet(isPresented: $showingAddNote) {
                AddNoteView { title, content in
                    let newNote = SecureNote(title: title, content: content, isLocked: false)
                    notes.append(newNote)
                }
            }
        }
    }
    
    private func toggleLock(for note: SecureNote) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].isLocked.toggle()
        }
    }
}

struct SecureNote: Identifiable {
    let id = UUID()
    let title: String
    let content: String
    var isLocked: Bool
}

struct AddNoteView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var content = ""
    let onSave: (String, String) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("노트 정보")) {
                    TextField("제목", text: $title)
                    TextField("내용", text: $content, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("새 노트")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("취소") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("저장") {
                        if !title.isEmpty && !content.isEmpty {
                            onSave(title, content)
                            dismiss()
                        }
                    }
                    .disabled(title.isEmpty || content.isEmpty)
                }
            }
        }
    }
}

#Preview {
    SecureNotesView()
}
