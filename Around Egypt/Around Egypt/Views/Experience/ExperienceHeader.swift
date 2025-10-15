//
//  ExperienceHeader.swift
//  Around Egypt
//
//  Created by Omar Mohamed on 15/10/2025.
//

import SwiftUI
import Kingfisher

struct ExperienceHeader: View {
    let experience: ExperienceDatum
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let cover = experience.coverPhoto, let url = URL(string: cover) {
                KFImage(url)
                    .resizable()
                    .frame(height: 280)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .cornerRadius(16)
                    .overlay(
                        // Explore Now button
                        VStack {
                            Button(action: {
                                // TODO: Open 360 view or details
                            }) {
                                Text("EXPLORE NOW")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.orange)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 24)
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .shadow(radius: 2)
                            }
                            .padding(.bottom, 16)
                        }
                            .frame(maxWidth: .infinity))
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 280)
            }
            
            // Bottom overlay info
            HStack {
                Label("\(experience.viewsNo ?? 0) views", systemImage: "eye")
                    .font(.footnote)
                    .foregroundColor(.white)
                    .padding(.leading, 8)
                
                Spacer()
                
                Image(systemName: "photo.on.rectangle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.white)
            }
            .padding()
        }
    }
}

#Preview {
    ZStack {
        Color(.black).opacity(0.2).edgesIgnoringSafeArea(.all)
        ExperienceHeader(experience: mockData)
    }
}
