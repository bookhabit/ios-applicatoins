//
//  ShopView.swift
//  ios-applications
//
//  Created by 비즈비 on 8/22/25.
//

import SwiftUI

struct ShopView: View {
    @State private var cartItems: [ShopItem] = []
    
    let shopItems = [
        ShopItem(name: "iPhone 15", price: 1200000, image: "iphone"),
        ShopItem(name: "MacBook Pro", price: 2500000, image: "laptopcomputer"),
        ShopItem(name: "AirPods Pro", price: 350000, image: "airpodspro"),
        ShopItem(name: "Apple Watch", price: 500000, image: "applewatch"),
        ShopItem(name: "iPad", price: 800000, image: "ipad"),
        ShopItem(name: "Mac mini", price: 800000, image: "macmini")
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        ForEach(shopItems) { item in
                            ShopItemCard(item: item) {
                                addToCart(item)
                            }
                        }
                    }
                    .padding()
                }
                
                if !cartItems.isEmpty {
                    VStack {
                        Text("장바구니: \(cartItems.count)개")
                            .font(.headline)
                        
                        Text("총액: ₩\(cartItems.reduce(0) { $0 + $1.price }.formatted())")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
            }
            .navigationTitle("상점")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("장바구니 비우기") {
                        cartItems.removeAll()
                    }
                    .disabled(cartItems.isEmpty)
                }
            }
        }
    }
    
    private func addToCart(_ item: ShopItem) {
        cartItems.append(item)
    }
}

struct ShopItem: Identifiable {
    let id = UUID()
    let name: String
    let price: Int
    let image: String
}

struct ShopItemCard: View {
    let item: ShopItem
    let onAddToCart: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: item.image)
                .font(.system(size: 40))
                .foregroundColor(.blue)
            
            Text(item.name)
                .font(.headline)
                .multilineTextAlignment(.center)
            
            Text("₩\(item.price.formatted())")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Button("장바구니에 추가") {
                onAddToCart()
            }
            .buttonStyle(.borderedProminent)
            .font(.caption)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

#Preview {
    ShopView()
}
