//
//  MiniFileExplorerView.swift
//  ios-applications
//
//  Created by 비즈비 on 8/22/25.
//

import SwiftUI

struct MiniFileExplorerView: View {
    @State private var searchText = ""
    @State private var selectedFolder = "문서"
    
    let folders = ["문서", "이미지", "음악", "비디오", "다운로드"]
    let files = [
        FileItem(name: "보고서.pdf", type: "PDF", size: "2.3MB"),
        FileItem(name: "프레젠테이션.pptx", type: "PowerPoint", size: "15.7MB"),
        FileItem(name: "스프레드시트.xlsx", type: "Excel", size: "8.9MB"),
        FileItem(name: "이미지.jpg", type: "Image", size: "3.2MB"),
        FileItem(name: "문서.txt", type: "Text", size: "1.1KB")
    ]
    
    var filteredFiles: [FileItem] {
        if searchText.isEmpty {
            return files
        } else {
            return files.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // 검색바
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    
                    TextField("파일 검색", text: $searchText)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
                
                // 폴더 선택
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(folders, id: \.self) { folder in
                            Button(folder) {
                                selectedFolder = folder
                            }
                            .buttonStyle(.bordered)
                            .background(selectedFolder == folder ? Color.blue : Color.clear)
                            .foregroundColor(selectedFolder == folder ? .white : .primary)
                            .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // 파일 목록
                List(filteredFiles) { file in
                    HStack {
                        Image(systemName: getFileIcon(for: file.type))
                            .foregroundColor(getFileColor(for: file.type))
                            .frame(width: 30)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(file.name)
                                .font(.headline)
                            
                            HStack {
                                Text(file.type)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                Spacer()
                                
                                Text(file.size)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("미니 파일 탐색기")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("새 폴더") {
                        // 새 폴더 생성 로직
                    }
                }
            }
        }
    }
    
    private func getFileIcon(for type: String) -> String {
        switch type {
        case "PDF": return "doc.text.fill"
        case "PowerPoint": return "doc.richtext.fill"
        case "Excel": return "tablecells.fill"
        case "Image": return "photo.fill"
        case "Text": return "doc.fill"
        default: return "doc"
        }
    }
    
    private func getFileColor(for type: String) -> Color {
        switch type {
        case "PDF": return .red
        case "PowerPoint": return .orange
        case "Excel": return .green
        case "Image": return .blue
        case "Text": return .gray
        default: return .primary
        }
    }
}

struct FileItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let size: String
}

#Preview {
    MiniFileExplorerView()
}
