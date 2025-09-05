import SwiftUI
import SQLite3

struct User: Identifiable, Codable {
    let id: Int
    let name: String
    let email: String
    let age: Int
}

struct CreateUserData {
    let name: String
    let email: String
    let age: Int
}

class SqliteManager: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    
    private var db: OpaquePointer?
    
    init() {
        openDatabase()
        createTable()
        loadUsers()
    }
    
    deinit {
        closeDatabase()
    }
    
    private func openDatabase() {
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("app_database.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Unable to open database")
        }
    }
    
    private func closeDatabase() {
        if sqlite3_close(db) != SQLITE_OK {
            print("Error closing database")
        }
    }
    
    private func createTable() {
        let createTableSQL = """
            CREATE TABLE IF NOT EXISTS users (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                email TEXT NOT NULL,
                age INTEGER NOT NULL
            );
        """
        
        var statement: OpaquePointer?
        if sqlite3_prepare_v2(db, createTableSQL, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Table created successfully")
            } else {
                print("Error creating table")
            }
        } else {
            print("Error preparing create table statement")
        }
        sqlite3_finalize(statement)
    }
    
    func loadUsers() {
        isLoading = true
        users.removeAll()
        
        let querySQL = "SELECT id, name, email, age FROM users ORDER BY name ASC"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, querySQL, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(statement, 0))
                let name = String(cString: sqlite3_column_text(statement, 1))
                let email = String(cString: sqlite3_column_text(statement, 2))
                let age = Int(sqlite3_column_int(statement, 3))
                
                let user = User(id: id, name: name, email: email, age: age)
                users.append(user)
            }
        } else {
            print("Error preparing query statement")
        }
        
        sqlite3_finalize(statement)
        isLoading = false
    }
    
    func addUser(_ userData: CreateUserData) {
        let insertSQL = "INSERT INTO users (name, email, age) VALUES (?, ?, ?)"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, insertSQL, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, userData.name, -1, nil)
            sqlite3_bind_text(statement, 2, userData.email, -1, nil)
            sqlite3_bind_int(statement, 3, Int32(userData.age))
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("User added successfully")
                loadUsers()
            } else {
                print("Error adding user")
            }
        } else {
            print("Error preparing insert statement")
        }
        
        sqlite3_finalize(statement)
    }
    
    func updateUser(id: Int, userData: CreateUserData) {
        let updateSQL = "UPDATE users SET name = ?, email = ?, age = ? WHERE id = ?"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, updateSQL, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, userData.name, -1, nil)
            sqlite3_bind_text(statement, 2, userData.email, -1, nil)
            sqlite3_bind_int(statement, 3, Int32(userData.age))
            sqlite3_bind_int(statement, 4, Int32(id))
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("User updated successfully")
                loadUsers()
            } else {
                print("Error updating user")
            }
        } else {
            print("Error preparing update statement")
        }
        
        sqlite3_finalize(statement)
    }
    
    func deleteUser(id: Int) {
        let deleteSQL = "DELETE FROM users WHERE id = ?"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, deleteSQL, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(id))
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("User deleted successfully")
                loadUsers()
            } else {
                print("Error deleting user")
            }
        } else {
            print("Error preparing delete statement")
        }
        
        sqlite3_finalize(statement)
    }
    
    func deleteAllUsers() {
        let deleteSQL = "DELETE FROM users"
        var statement: OpaquePointer?
        
        if sqlite3_prepare_v2(db, deleteSQL, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("All users deleted successfully")
                loadUsers()
            } else {
                print("Error deleting all users")
            }
        } else {
            print("Error preparing delete all statement")
        }
        
        sqlite3_finalize(statement)
    }
}

struct SqliteView: View {
    @StateObject private var sqliteManager = SqliteManager()
    @State private var name = ""
    @State private var email = ""
    @State private var age = ""
    @State private var editingUser: User?
    @State private var showingAddUser = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("SQLite 사용자 관리")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("총 \(sqliteManager.users.count)명의 사용자")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemBackground))
                
                if sqliteManager.isLoading {
                    Spacer()
                    ProgressView("데이터를 불러오는 중...")
                        .font(.headline)
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            // Add User Form
                            VStack(alignment: .leading, spacing: 16) {
                                Text("새 사용자 추가")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                VStack(spacing: 12) {
                                    TextField("이름", text: $name)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    
                                    TextField("이메일", text: $email)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.emailAddress)
                                        .autocapitalization(.none)
                                    
                                    TextField("나이", text: $age)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.numberPad)
                                }
                                
                                HStack(spacing: 12) {
                                    Button(action: addUser) {
                                        HStack {
                                            Image(systemName: "plus")
                                            Text("추가")
                                        }
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.blue)
                                        .cornerRadius(8)
                                    }
                                    
                                    Button(action: deleteAllUsers) {
                                        HStack {
                                            Image(systemName: "trash")
                                            Text("전체 삭제")
                                        }
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.red)
                                        .cornerRadius(8)
                                    }
                                }
                            }
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(12)
                            
                            // Users List
                            VStack(alignment: .leading, spacing: 16) {
                                Text("사용자 목록")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                if sqliteManager.users.isEmpty {
                                    VStack(spacing: 16) {
                                        Image(systemName: "person.3")
                                            .font(.system(size: 48))
                                            .foregroundColor(.gray)
                                        
                                        Text("사용자가 없습니다")
                                            .font(.headline)
                                            .foregroundColor(.secondary)
                                        
                                        Text("새 사용자를 추가해보세요")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 40)
                                } else {
                                    LazyVStack(spacing: 12) {
                                        ForEach(sqliteManager.users) { user in
                                            UserRowView(
                                                user: user,
                                                onEdit: { editUser(user) },
                                                onDelete: { deleteUser(user) }
                                            )
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(12)
                        }
                        .padding()
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .alert("알림", isPresented: $showingAlert) {
            Button("확인") { }
        } message: {
            Text(alertMessage)
        }
    }
    
    private func addUser() {
        guard !name.isEmpty && !email.isEmpty && !age.isEmpty else {
            alertMessage = "모든 필드를 입력해주세요."
            showingAlert = true
            return
        }
        
        guard let ageInt = Int(age), ageInt > 0 else {
            alertMessage = "올바른 나이를 입력해주세요."
            showingAlert = true
            return
        }
        
        let userData = CreateUserData(name: name, email: email, age: ageInt)
        
        if let editingUser = editingUser {
            sqliteManager.updateUser(id: editingUser.id, userData: userData)
            alertMessage = "사용자가 수정되었습니다."
            self.editingUser = nil
        } else {
            sqliteManager.addUser(userData)
            alertMessage = "사용자가 추가되었습니다."
        }
        
        name = ""
        email = ""
        age = ""
        showingAlert = true
    }
    
    private func editUser(_ user: User) {
        editingUser = user
        name = user.name
        email = user.email
        age = String(user.age)
    }
    
    private func deleteUser(_ user: User) {
        let alert = UIAlertController(
            title: "사용자 삭제",
            message: "\(user.name)을(를) 삭제하시겠습니까?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive) { _ in
            sqliteManager.deleteUser(id: user.id)
            alertMessage = "사용자가 삭제되었습니다."
            showingAlert = true
        })
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController?.present(alert, animated: true)
        }
    }
    
    private func deleteAllUsers() {
        let alert = UIAlertController(
            title: "전체 삭제",
            message: "모든 사용자를 삭제하시겠습니까?",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive) { _ in
            sqliteManager.deleteAllUsers()
            alertMessage = "모든 사용자가 삭제되었습니다."
            showingAlert = true
        })
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController?.present(alert, animated: true)
        }
    }
}

struct UserRowView: View {
    let user: User
    let onEdit: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(user.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("나이: \(user.age)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            HStack(spacing: 12) {
                Button(action: onEdit) {
                    Image(systemName: "pencil")
                        .foregroundColor(.blue)
                        .frame(width: 32, height: 32)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                }
                
                Button(action: onDelete) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .frame(width: 32, height: 32)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    SqliteView()
}
