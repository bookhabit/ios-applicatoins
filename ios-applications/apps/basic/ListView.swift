import SwiftUI

struct ListView: View {
    @State private var selectedDemo: String?
    
    let listViewDemos = [
        ListViewDemo(
            id: "adapter-view-demo",
            title: "AdapterView 데모",
            description: "ListView와 ArrayAdapter를 사용한 기본 리스트 구현",
            icon: "📱"
        ),
        ListViewDemo(
            id: "recycler-view-demo",
            title: "RecyclerView 데모",
            description: "RecyclerView와 ViewHolder 패턴을 사용한 고성능 리스트",
            icon: "🔄"
        ),
        ListViewDemo(
            id: "spinner-demo",
            title: "Spinner 데모",
            description: "드롭다운 선택 박스 구현",
            icon: "⬇️"
        ),
        ListViewDemo(
            id: "fragment-demo",
            title: "Fragment 데모",
            description: "모듈화된 UI 단위 Fragment 구현",
            icon: "🧩"
        ),
        ListViewDemo(
            id: "view-pager-demo",
            title: "ViewPager 데모",
            description: "스와이프 가능한 페이지 전환 컨테이너",
            icon: "📄"
        ),
        ListViewDemo(
            id: "compose-lazy-demo",
            title: "Compose Lazy 데모",
            description: "Jetpack Compose의 LazyColumn/LazyRow 사용법",
            icon: "⚡"
        )
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("리스트 뷰 학습")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    // 사용 가능한 데모
                    VStack(alignment: .leading, spacing: 15) {
                        Text("사용 가능한 데모")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text("각 데모를 선택하여 리스트 뷰의 다양한 구현 방법을 학습하세요.")
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // 데모 목록
                    LazyVStack(spacing: 15) {
                        ForEach(listViewDemos) { demo in
                            DemoItemView(
                                demo: demo,
                                isSelected: selectedDemo == demo.id,
                                onTap: {
                                    selectedDemo = demo.id
                                }
                            )
                        }
                    }
                    
                    // 선택된 데모 정보
                    if let selectedDemo = selectedDemo,
                       let demo = listViewDemos.first(where: { $0.id == selectedDemo }) {
                        VStack(alignment: .leading, spacing: 15) {
                            Text("선택된 데모")
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            Text(demo.title)
                                .font(.body)
                            
                            HStack(spacing: 15) {
                                Button("데모 실행") {
                                    // 실제로는 해당 데모 스크린으로 이동
                                    print("Selected demo: \(demo.title)")
                                }
                                .buttonStyle(.borderedProminent)
                                
                                Button("선택 해제") {
                                    self.selectedDemo = nil
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(12)
                    }
                    
                    // 리스트 뷰 종류 정보
                    VStack(alignment: .leading, spacing: 15) {
                        Text("리스트 뷰 종류")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("• AdapterView: 기본적인 리스트 뷰 구현")
                            Text("• RecyclerView: 고성능 리스트 뷰 (권장)")
                            Text("• Spinner: 드롭다운 선택 박스")
                            Text("• Fragment: 모듈화된 UI 단위")
                            Text("• ViewPager: 스와이프 가능한 페이지")
                            Text("• Compose Lazy: Jetpack Compose의 리스트")
                        }
                        .font(.body)
                        .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .padding()
            }
            .navigationTitle("리스트 뷰")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct DemoItemView: View {
    let demo: ListViewDemo
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 15) {
                Text(demo.icon)
                    .font(.system(size: 32))
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(demo.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    Text(demo.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.blue)
                    .fontWeight(.bold)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ListViewDemo: Identifiable {
    let id: String
    let title: String
    let description: String
    let icon: String
}

#Preview {
    ListView()
}
