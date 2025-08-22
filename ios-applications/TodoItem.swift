import Foundation

struct TodoItem: Identifiable, Codable {
    let id: String
    var text: String
    var completed: Bool
    var createdAt: Date
    
    init(id: String = UUID().uuidString, text: String, completed: Bool = false, createdAt: Date = Date()) {
        self.id = id
        self.text = text
        self.completed = completed
        self.createdAt = createdAt
    }
}
