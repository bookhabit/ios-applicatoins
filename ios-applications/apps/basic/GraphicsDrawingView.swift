import SwiftUI

struct GraphicsDrawingView: View {
    @State private var currentColor: Color = .black
    @State private var lineWidth: CGFloat = 5
    @State private var showColorPicker = false
    @State private var showWidthSlider = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // 도구 바
                HStack(spacing: 20) {
                    Button(action: { showColorPicker.toggle() }) {
                        Image(systemName: "paintpalette.fill")
                            .font(.title2)
                            .foregroundColor(currentColor)
                    }
                    .sheet(isPresented: $showColorPicker) {
                        ColorPickerView(selectedColor: $currentColor)
                    }
                    
                    Button(action: { showWidthSlider.toggle() }) {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    .sheet(isPresented: $showWidthSlider) {
                        WidthSliderView(lineWidth: $lineWidth)
                    }
                    
                    Spacer()
                    
                    Button("지우기") {
                        // 캔버스 지우기
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
                .background(Color(.systemGray6))
                
                // 캔버스
                DrawingCanvas(
                    currentColor: currentColor,
                    lineWidth: lineWidth
                )
                .background(Color.white)
                .border(Color.gray, width: 1)
            }
            .navigationTitle("그래픽 그리기")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct DrawingCanvas: View {
    let currentColor: Color
    let lineWidth: CGFloat
    
    @State private var lines: [Line] = []
    @State private var currentLine: Line?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 배경
                Color.white
                
                // 그려진 선들
                ForEach(lines) { line in
                    Path { path in
                        path.addLines(line.points)
                    }
                    .stroke(line.color, lineWidth: line.width)
                }
                
                // 현재 그리는 선
                if let currentLine = currentLine {
                    Path { path in
                        path.addLines(currentLine.points)
                    }
                    .stroke(currentLine.color, lineWidth: currentLine.width)
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        let point = value.location
                        
                        if currentLine == nil {
                            currentLine = Line(
                                points: [point],
                                color: currentColor,
                                width: lineWidth
                            )
                        } else {
                            currentLine?.points.append(point)
                        }
                    }
                    .onEnded { _ in
                        if let line = currentLine {
                            lines.append(line)
                            currentLine = nil
                        }
                    }
            )
        }
    }
}

struct Line: Identifiable {
    let id = UUID()
    var points: [CGPoint]
    let color: Color
    let width: CGFloat
}

struct ColorPickerView: View {
    @Binding var selectedColor: Color
    @Environment(\.dismiss) private var dismiss
    
    let colors: [Color] = [
        .black, .red, .orange, .yellow, .green, .blue, .purple, .pink,
        .gray, .brown, .cyan, .mint, .indigo, .teal
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("색상 선택")
                    .font(.title)
                    .fontWeight(.bold)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 15) {
                    ForEach(colors, id: \.self) { color in
                        Circle()
                            .fill(color)
                            .frame(width: 50, height: 50)
                            .overlay(
                                Circle()
                                    .stroke(selectedColor == color ? Color.blue : Color.clear, lineWidth: 3)
                            )
                            .onTapGesture {
                                selectedColor = color
                                dismiss()
                            }
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("색상 선택")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("닫기") {
                dismiss()
            })
        }
    }
}

struct WidthSliderView: View {
    @Binding var lineWidth: CGFloat
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("선 굵기 설정")
                    .font(.title)
                    .fontWeight(.bold)
                
                VStack(spacing: 20) {
                    Text("현재 굵기: \(Int(lineWidth))")
                        .font(.headline)
                    
                    Slider(value: $lineWidth, in: 1...20, step: 1)
                        .accentColor(.blue)
                    
                    // 미리보기
                    Rectangle()
                        .fill(Color.black)
                        .frame(height: lineWidth)
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(5)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                Spacer()
            }
            .padding()
            .navigationTitle("선 굵기 설정")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("닫기") {
                dismiss()
            })
        }
    }
}

#Preview {
    GraphicsDrawingView()
}
