import SwiftUI

struct CalculatorView: View {
    @State private var display = "0"
    @State private var operation: String?
    @State private var firstNumber: Double?
    @State private var newNumber = true
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // 디스플레이
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text(display)
                            .font(.system(size: 64, weight: .light))
                            .foregroundColor(.primary)
                    }
                    .padding(.horizontal, 20)
                }
                .frame(height: 200)
                
                // 버튼들
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        CalculatorButton(title: "C", action: clear, color: .gray)
                        CalculatorButton(title: "±", action: toggleSign, color: .gray)
                        CalculatorButton(title: "%", action: percentage, color: .gray)
                        CalculatorButton(title: "÷", action: { setOperation("÷") }, color: .orange)
                    }
                    
                    HStack(spacing: 10) {
                        CalculatorButton(title: "7", action: { appendNumber("7") })
                        CalculatorButton(title: "8", action: { appendNumber("8") })
                        CalculatorButton(title: "9", action: { appendNumber("9") })
                        CalculatorButton(title: "×", action: { setOperation("×") }, color: .orange)
                    }
                    
                    HStack(spacing: 10) {
                        CalculatorButton(title: "4", action: { appendNumber("4") })
                        CalculatorButton(title: "5", action: { appendNumber("5") })
                        CalculatorButton(title: "6", action: { appendNumber("6") })
                        CalculatorButton(title: "-", action: { setOperation("-") }, color: .orange)
                    }
                    
                    HStack(spacing: 10) {
                        CalculatorButton(title: "1", action: { appendNumber("1") })
                        CalculatorButton(title: "2", action: { appendNumber("2") })
                        CalculatorButton(title: "3", action: { appendNumber("3") })
                        CalculatorButton(title: "+", action: { setOperation("+") }, color: .orange)
                    }
                    
                    HStack(spacing: 10) {
                        CalculatorButton(title: "0", action: { appendNumber("0") }, isWide: true)
                        CalculatorButton(title: ".", action: appendDecimal)
                        CalculatorButton(title: "=", action: calculate, color: .orange)
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .navigationTitle("계산기")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func appendNumber(_ number: String) {
        if newNumber {
            display = number
            newNumber = false
        } else {
            if display == "0" {
                display = number
            } else {
                display += number
            }
        }
    }
    
    private func appendDecimal() {
        if newNumber {
            display = "0."
            newNumber = false
        } else if !display.contains(".") {
            display += "."
        }
    }
    
    private func setOperation(_ op: String) {
        firstNumber = Double(display)
        operation = op
        newNumber = true
    }
    
    private func calculate() {
        guard let first = firstNumber,
              let op = operation,
              let second = Double(display) else { return }
        
        var result: Double = 0
        
        switch op {
        case "+":
            result = first + second
        case "-":
            result = first - second
        case "×":
            result = first * second
        case "÷":
            result = second != 0 ? first / second : 0
        default:
            result = second
        }
        
        display = String(format: "%g", result)
        operation = nil
        firstNumber = nil
        newNumber = true
    }
    
    private func clear() {
        display = "0"
        operation = nil
        firstNumber = nil
        newNumber = true
    }
    
    private func toggleSign() {
        if let value = Double(display) {
            display = String(format: "%g", -value)
        }
    }
    
    private func percentage() {
        if let value = Double(display) {
            display = String(format: "%g", value / 100)
        }
    }
}

struct CalculatorButton: View {
    let title: String
    let action: () -> Void
    var color: Color = .secondary
    var isWide: Bool = false
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .frame(width: isWide ? 160 : 80, height: 80)
                .background(color)
                .cornerRadius(40)
        }
    }
}

#Preview {
    CalculatorView()
}
