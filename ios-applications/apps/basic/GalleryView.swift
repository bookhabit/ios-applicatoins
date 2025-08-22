//
//  GalleryView.swift
//  ios-applications
//
//  Created by 비즈비 on 8/22/25.
//

import SwiftUI

struct GalleryView: View {
    let sampleImages = [
        "photo", "photo.fill", "camera", "camera.fill",
        "photo.on.rectangle", "photo.on.rectangle.angled",
        "rectangle.stack", "rectangle.stack.fill"
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(sampleImages, id: \.self) { imageName in
                        Image(systemName: imageName)
                            .font(.system(size: 40))
                            .foregroundColor(.blue)
                            .frame(width: 100, height: 100)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(12)
                    }
                }
                .padding()
            }
            .navigationTitle("갤러리")
        }
    }
}

#Preview {
    GalleryView()
}
