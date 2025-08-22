//
//  MediaNotesView.swift
//  ios-applications
//
//  Created by 비즈비 on 8/22/25.
//

import SwiftUI

struct MediaNotesView: View {
    @State private var notes: [MediaNote] = [
        MediaNote(title: "영화 리뷰", content: "인셉션 - 꿈과 현실의 경계가 모호한 작품", type: "영화", rating: 5),
        MediaNote(title: "책 노트", content: "1984 - 디스토피아 소설의 걸작", type: "책", rating: 4),
        MediaNote(title: "음악 감상", content: "Beethoven Symphony No.9 - 장엄한 교향곡", type: "음악", rating: 5)
    ]
    @State private var showingAddNote = false
    @State private var selectedType = "전체"
    
    let mediaTypes = ["전체", "영화", "책", "음악", "게임", "드라마"]
    
    var filteredNotes: [MediaNote] {
        if selectedType == "전체" {
            return notes
        } else {
            return notes.filter { $0.type == selectedType }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // 미디어 타입 선택
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(mediaTypes, id: \.self) { type in
                            Button(type) {
                                selectedType = type
                            }
                            .buttonStyle(.bordered)
                            .background(selectedType == type ? Color.blue : Color.clear)
                            .foregroundColor(selectedType == type ? .white : .primary)
                            .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // 노트 목록
                List(filteredNotes) { note in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: getMediaIcon(for: note.type))
                                .foregroundColor(getMediaColor(for: note.type))
                                .font(.title2)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(note.title)
                                    .font(.headline)
                                
                                HStack {
                                    Text(note.type)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    
                                    Spacer()
                                    
                                    HStack(spacing: 2) {
                                        ForEach(1...5, id: \.self) { star in
                                            Image(systemName: star <= note.rating ? "star.fill" : "star")
                                                .foregroundColor(.yellow)
                                                .font(.caption)
                                        }
                                    }
                                }
                            }
                            
                            Spacer()
                        }
                        
                        Text(note.content)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineLimit(3)
                            .padding(.leading, 40)
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("미디어 노트")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("새 노트") {
                        showingAddNote = true
                    }
                }
            }
            .sheet(isPresented: $showingAddNote) {
                AddMediaNoteView { title, content, type, rating in
                    let newNote = MediaNote(title: title, content: content, type: type, rating: rating)
                    notes.append(newNote)
                }
            }
        }
    }
    
    private func getMediaIcon(for type: String) -> String {
        switch type {
        case "영화": return "film"
        case "책": return "book"
        case "음악": return "music.note"
        case "게임": return "gamecontroller"
        case "드라마": return "tv"
        default: return "doc.text"
        }
    }
    
    private func getMediaColor(for type: String) -> Color {
        switch type {
        case "영화": return .red
        case "책": return .brown
        case "음악": return .purple
        case "게임": return .green
        case "드라마": return .blue
        default: return .gray
        }
    }
}

struct MediaNote: Identifiable {
    let id = UUID()
    let title: String
    let content: String
    let type: String
    let rating: Int
}

struct AddMediaNoteView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var content = ""
    @State private var type = "영화"
    @State private var rating = 3
    let onSave: (String, String, String, Int) -> Void
    
    let mediaTypes = ["영화", "책", "음악", "게임", "드라마"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("미디어 정보")) {
                    TextField("제목", text: $title)
                    
                    Picker("타입", selection: $type) {
                        ForEach(mediaTypes, id: \.self) { type in
                            Text(type).tag(type)
                        }
                    }
                    
                    TextField("내용", text: $content, axis: .vertical)
                        .lineLimit(3...6)
                }
                
                Section(header: Text("평점")) {
                    HStack {
                        Text("평점:")
                        Spacer()
                        HStack(spacing: 2) {
                            ForEach(1...5, id: \.self) { star in
                                Button(action: {
                                    rating = star
                                }) {
                                    Image(systemName: star <= rating ? "star.fill" : "star")
                                        .foregroundColor(.yellow)
                                        .font(.title2)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("새 미디어 노트")
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
                            onSave(title, content, type, rating)
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
    MediaNotesView()
}
