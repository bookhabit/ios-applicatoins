//
//  TripLoggerView.swift
//  ios-applications
//
//  Created by 비즈비 on 8/22/25.
//

import SwiftUI

struct TripLoggerView: View {
    @State private var trips: [Trip] = [
        Trip(destination: "도쿄", date: "2024-03-15", duration: "5일", notes: "벚꽃 축제 관람"),
        Trip(destination: "파리", date: "2024-06-20", duration: "7일", notes: "에펠탑, 루브르 박물관"),
        Trip(destination: "뉴욕", date: "2024-09-10", duration: "6일", notes: "타임스퀘어, 센트럴파크")
    ]
    @State private var showingAddTrip = false
    @State private var searchText = ""
    
    var filteredTrips: [Trip] {
        if searchText.isEmpty {
            return trips
        } else {
            return trips.filter { $0.destination.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // 검색바
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    
                    TextField("여행지 검색", text: $searchText)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal)
                
                // 여행 목록
                List(filteredTrips) { trip in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "airplane.circle.fill")
                                .foregroundColor(.blue)
                                .font(.title2)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(trip.destination)
                                    .font(.headline)
                                
                                HStack {
                                    Text(trip.date)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    
                                    Text("•")
                                        .foregroundColor(.secondary)
                                    
                                    Text(trip.duration)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            
                            Spacer()
                            
                            Button("편집") {
                                // 편집 로직
                            }
                            .buttonStyle(.bordered)
                            .font(.caption)
                        }
                        
                        if !trip.notes.isEmpty {
                            Text(trip.notes)
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.leading, 40)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("여행 로거")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("새 여행") {
                        showingAddTrip = true
                    }
                }
            }
            .sheet(isPresented: $showingAddTrip) {
                AddTripView { destination, date, duration, notes in
                    let newTrip = Trip(destination: destination, date: date, duration: duration, notes: notes)
                    trips.append(newTrip)
                }
            }
        }
    }
}

struct Trip: Identifiable {
    let id = UUID()
    let destination: String
    let date: String
    let duration: String
    let notes: String
}

struct AddTripView: View {
    @Environment(\.dismiss) var dismiss
    @State private var destination = ""
    @State private var date = ""
    @State private var duration = ""
    @State private var notes = ""
    let onSave: (String, String, String, String) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("여행 정보")) {
                    TextField("목적지", text: $destination)
                    TextField("날짜", text: $date)
                    TextField("기간", text: $duration)
                    TextField("메모", text: $notes, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("새 여행")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("취소") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("저장") {
                        if !destination.isEmpty && !date.isEmpty && !duration.isEmpty {
                            onSave(destination, date, duration, notes)
                            dismiss()
                        }
                    }
                    .disabled(destination.isEmpty || date.isEmpty || duration.isEmpty)
                }
            }
        }
    }
}

#Preview {
    TripLoggerView()
}
