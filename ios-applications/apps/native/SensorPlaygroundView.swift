//
//  SensorPlaygroundView.swift
//  ios-applications
//
//  Created by 비즈비 on 8/22/25.
//

import SwiftUI
import CoreMotion

struct SensorPlaygroundView: View {
    @State private var accelerometerData = AccelerometerData()
    @State private var gyroscopeData = GyroscopeData()
    @State private var magnetometerData = MagnetometerData()
    @State private var isMonitoring = false
    
    private let motionManager = CMMotionManager()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // 가속도계
                    SensorCard(
                        title: "가속도계",
                        icon: "speedometer",
                        color: .blue,
                        data: [
                            ("X축", String(format: "%.2f", accelerometerData.x)),
                            ("Y축", String(format: "%.2f", accelerometerData.y)),
                            ("Z축", String(format: "%.2f", accelerometerData.z))
                        ]
                    )
                    
                    // 자이로스코프
                    SensorCard(
                        title: "자이로스코프",
                        icon: "gyroscope",
                        color: .green,
                        data: [
                            ("X축", String(format: "%.2f", gyroscopeData.x)),
                            ("Y축", String(format: "%.2f", gyroscopeData.y)),
                            ("Z축", String(format: "%.2f", gyroscopeData.z))
                        ]
                    )
                    
                    // 자기계
                    SensorCard(
                        title: "자기계",
                        icon: "compass",
                        color: .red,
                        data: [
                            ("X축", String(format: "%.2f", magnetometerData.x)),
                            ("Y축", String(format: "%.2f", magnetometerData.y)),
                            ("Z축", String(format: "%.2f", magnetometerData.z))
                        ]
                    )
                    
                    // 시각화
                    VStack(spacing: 16) {
                        Text("센서 시각화")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        ZStack {
                            Circle()
                                .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                                .frame(width: 200, height: 200)
                            
                            // 가속도계 시각화
                            Circle()
                                .fill(Color.blue.opacity(0.6))
                                .frame(width: 20, height: 20)
                                .offset(
                                    x: CGFloat(accelerometerData.x * 50),
                                    y: CGFloat(accelerometerData.y * 50)
                                )
                                .animation(.easeInOut(duration: 0.1), value: accelerometerData.x)
                                .animation(.easeInOut(duration: 0.1), value: accelerometerData.y)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(16)
                    
                    // 컨트롤
                    Button(isMonitoring ? "센서 중지" : "센서 시작") {
                        toggleMonitoring()
                    }
                    .buttonStyle(.borderedProminent)
                    .font(.title3)
                }
                .padding()
            }
            .navigationTitle("센서 놀이터")
            .onAppear {
                setupMotionManager()
            }
            .onDisappear {
                stopMonitoring()
            }
        }
    }
    
    private func setupMotionManager() {
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.gyroUpdateInterval = 0.1
        motionManager.magnetometerUpdateInterval = 0.1
    }
    
    private func toggleMonitoring() {
        if isMonitoring {
            stopMonitoring()
        } else {
            startMonitoring()
        }
    }
    
    private func startMonitoring() {
        guard motionManager.isAccelerometerAvailable else { return }
        
        motionManager.startAccelerometerUpdates(to: .main) { data, error in
            guard let data = data else { return }
            accelerometerData = AccelerometerData(
                x: data.acceleration.x,
                y: data.acceleration.y,
                z: data.acceleration.z
            )
        }
        
        if motionManager.isGyroAvailable {
            motionManager.startGyroUpdates(to: .main) { data, error in
                guard let data = data else { return }
                gyroscopeData = GyroscopeData(
                    x: data.rotationRate.x,
                    y: data.rotationRate.y,
                    z: data.rotationRate.z
                )
            }
        }
        
        if motionManager.isMagnetometerAvailable {
            motionManager.startMagnetometerUpdates(to: .main) { data, error in
                guard let data = data else { return }
                magnetometerData = MagnetometerData(
                    x: data.magneticField.x,
                    y: data.magneticField.y,
                    z: data.magneticField.z
                )
            }
        }
        
        isMonitoring = true
    }
    
    private func stopMonitoring() {
        motionManager.stopAccelerometerUpdates()
        motionManager.stopGyroUpdates()
        motionManager.stopMagnetometerUpdates()
        isMonitoring = false
    }
}

struct AccelerometerData {
    var x: Double = 0.0
    var y: Double = 0.0
    var z: Double = 0.0
}

struct GyroscopeData {
    var x: Double = 0.0
    var y: Double = 0.0
    var z: Double = 0.0
}

struct MagnetometerData {
    var x: Double = 0.0
    var y: Double = 0.0
    var z: Double = 0.0
}

struct SensorCard: View {
    let title: String
    let icon: String
    let color: Color
    let data: [(String, String)]
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
                
                Text(title)
                    .font(.headline)
                
                Spacer()
            }
            
            HStack {
                ForEach(data, id: \.0) { item in
                    VStack(spacing: 4) {
                        Text(item.0)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text(item.1)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(color)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(16)
    }
}

#Preview {
    SensorPlaygroundView()
}
