import SwiftUI

struct TodoView: View {
    @State private var todos: [TodoItem] = []
    @State private var newTodoText: String = ""
    @State private var filter: FilterType = .all
    
    enum FilterType: String, CaseIterable {
        case all = "전체"
        case active = "진행중"
        case completed = "완료"
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // 헤더
                VStack(spacing: 10) {
                    Text("To-Do 리스트")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("할 일을 관리하고 완료 상태를 추적하는 앱입니다.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                // 입력 필드
                HStack {
                    TextField("새로운 할 일을 입력하세요...", text: $newTodoText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onSubmit {
                            addTodo()
                        }
                    
                    Button("추가") {
                        addTodo()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(newTodoText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding(.horizontal)
                
                // 필터 버튼
                HStack(spacing: 8) {
                    ForEach(FilterType.allCases, id: \.self) { filterType in
                        Button(action: {
                            filter = filterType
                        }) {
                            Text("\(filterType.rawValue) (\(getCount(for: filterType)))")
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(filter == filterType ? Color.blue : Color.gray.opacity(0.2))
                                .foregroundColor(filter == filterType ? .white : .primary)
                                .cornerRadius(20)
                        }
                    }
                }
                .padding(.horizontal)
                
                // 할 일 목록
                List {
                    ForEach(filteredTodos) { todo in
                        TodoRowView(todo: todo) { updatedTodo in
                            if let index = todos.firstIndex(where: { $0.id == updatedTodo.id }) {
                                todos[index] = updatedTodo
                                saveTodos()
                            }
                        } onDelete: {
                            deleteTodo(todo)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                
                // 완료된 할 일 삭제 버튼
                if todos.contains(where: { $0.completed }) {
                    Button("완료된 할 일 모두 삭제") {
                        clearCompleted()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    .padding()
                }
            }
            .navigationTitle("할 일 관리")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            loadTodos()
        }
    }
    
    private var filteredTodos: [TodoItem] {
        switch filter {
        case .all:
            return todos
        case .active:
            return todos.filter { !$0.completed }
        case .completed:
            return todos.filter { $0.completed }
        }
    }
    
    private func getCount(for filterType: FilterType) -> Int {
        switch filterType {
        case .all:
            return todos.count
        case .active:
            return todos.filter { !$0.completed }.count
        case .completed:
            return todos.filter { $0.completed }.count
        }
    }
    
    private func addTodo() {
        let trimmedText = newTodoText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return }
        
        let newTodo = TodoItem(text: trimmedText)
        todos.append(newTodo)
        newTodoText = ""
        saveTodos()
    }
    
    private func deleteTodo(_ todo: TodoItem) {
        todos.removeAll { $0.id == todo.id }
        saveTodos()
    }
    
    private func clearCompleted() {
        todos.removeAll { $0.completed }
        saveTodos()
    }
    
    private func saveTodos() {
        // UserDefaults에 저장
        if let encoded = try? JSONEncoder().encode(todos) {
            UserDefaults.standard.set(encoded, forKey: "todos")
        }
    }
    
    private func loadTodos() {
        if let data = UserDefaults.standard.data(forKey: "todos"),
           let decoded = try? JSONDecoder().decode([TodoItem].self, from: data) {
            todos = decoded
        }
    }
}

struct TodoRowView: View {
    let todo: TodoItem
    let onUpdate: (TodoItem) -> Void
    let onDelete: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                var updatedTodo = todo
                updatedTodo.completed.toggle()
                onUpdate(updatedTodo)
            }) {
                Image(systemName: todo.completed ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(todo.completed ? .blue : .primary)
                    .font(.title2)
            }
            .buttonStyle(PlainButtonStyle())
            
            Text(todo.text)
                .strikethrough(todo.completed)
                .foregroundColor(todo.completed ? .secondary : .primary)
            
            Spacer()
            
            Button(action: onDelete) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    TodoView()
}
