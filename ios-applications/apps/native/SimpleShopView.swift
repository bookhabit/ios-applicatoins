//
//  SimpleShopView.swift
//  ios-applications
//
//  Created by 비즈비 on 8/22/25.
//

import SwiftUI

struct SimpleShopView: View {
    @State private var cartItems: [ShopProduct] = []
    @State private var selectedCategory = "전체"
    
    let categories = ["전체", "전자제품", "의류", "도서", "스포츠"]
    let products = [
        ShopProduct(name: "iPhone 15", price: 1200000, category: "전자제품", image: "iphone"),
        ShopProduct(name: "MacBook Pro", price: 2500000, category: "전자제품", image: "laptopcomputer"),
        ShopProduct(name: "Nike 운동화", price: 150000, category: "스포츠", image: "shoe"),
        ShopProduct(name: "Adidas 티셔츠", price: 80000, category: "의류", image: "tshirt"),
        ShopProduct(name: "Swift 프로그래밍", price: 35000, category: "도서", image: "book"),
        ShopProduct(name: "AirPods Pro", price: 350000, category: "전자제품", image: "airpodspro")
    ]
    
    var filteredProducts: [ShopProduct] {
        if selectedCategory == "전체" {
            return products
        } else {
            return products.filter { $0.category == selectedCategory }
        }
    }
    
    var totalPrice: Int {
        cartItems.reduce(0) { $0 + $1.price }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // 카테고리 선택
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(categories, id: \.self) { category in
                            Button(category) {
                                selectedCategory = category
                            }
                            .buttonStyle(.bordered)
                            .background(selectedCategory == category ? Color.blue : Color.clear)
                            .foregroundColor(selectedCategory == category ? .white : .primary)
                            .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                }
                
                // 상품 목록
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        ForEach(filteredProducts) { product in
                            ProductCard(product: product) {
                                addToCart(product)
                            }
                        }
                    }
                    .padding()
                }
                
                // 장바구니 요약
                if !cartItems.isEmpty {
                    VStack {
                        HStack {
                            Text("장바구니: \(cartItems.count)개")
                                .font(.headline)
                            
                            Spacer()
                            
                            Text("₩\(totalPrice.formatted())")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                        }
                        
                        Button("구매하기") {
                            // 구매 로직
                        }
                        .buttonStyle(.borderedProminent)
                        .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
            }
            .navigationTitle("심플 상점")
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
    
    private func addToCart(_ product: ShopProduct) {
        cartItems.append(product)
    }
}

struct ShopProduct: Identifiable {
    let id = UUID()
    let name: String
    let price: Int
    let category: String
    let image: String
}

struct ProductCard: View {
    let product: ShopProduct
    let onAddToCart: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: product.image)
                .font(.system(size: 40))
                .foregroundColor(.blue)
            
            Text(product.name)
                .font(.headline)
                .multilineTextAlignment(.center)
                .lineLimit(2)
            
            Text(product.category)
                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
            
            Text("₩\(product.price.formatted())")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
            
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
    SimpleShopView()
}
