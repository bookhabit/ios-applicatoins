import SwiftUI

struct NotesView: View {
    @State private var notes: [String] = ["첫 번째 메모", "두 번째 메모"]
    @State private var newNote: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("새 메모 입력...", text: $newNote)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("추가") {
                    if !newNote.isEmpty {
                        notes.append(newNote)
                        newNote = ""
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            
            List {
                ForEach(notes.indices, id: \.self) { index in
                    Text(notes[index])
                }
                .onDelete(perform: deleteNotes)
            }
        }
        .navigationTitle("메모 작성")
    }
    
    private func deleteNotes(offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
    }
}

#Preview {
    NavigationView {
        NotesView()
    }
}
