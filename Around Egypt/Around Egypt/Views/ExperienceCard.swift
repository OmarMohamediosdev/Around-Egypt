//
//  ExperienceCardHorizontal.swift
//  Around Egypt
//
//  Created by Omar Mohamed on 14/10/2025.
//

import SwiftUI
import Kingfisher

struct ExperienceCard: View {
    let experience: ExperienceDatum
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                if let cover = experience.coverPhoto, let url = URL(string: cover) {
                    KFImage(url)
                        .placeholder { ProgressView() }
                        .resizable()
//                        .scaledToFill()
                        .frame(height: 180)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(LinearGradient(colors: [.clear, .black.opacity(0.4)], startPoint: .top, endPoint: .bottom))
                        )
                        .overlay(
                            Image(systemName: "circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                                .overlay(
                                    Text("360")
                                        .foregroundColor(.white)
                                )
                        )
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        if experience.recommended ?? 0 == 1 {
                            HStack {
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(.orange)
                                Text("RECOMMENDED")
                                    .font(.caption2)
                                    .fontWeight(.bold)
                                
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.gray.opacity(0.5))
                            .foregroundColor(.white)
                            .cornerRadius(6)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "info.circle")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.white)
                            
                    }
                    
                    
                    Spacer()
                    
                    HStack {
                        Label("\(experience.viewsNo ?? 0)", systemImage: "eye")
                            .font(.caption)
                            .foregroundColor(.white)
                        Spacer()
                        
                        Image(systemName: "photo.on.rectangle")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.white)
                    }
                    
                    
                }
                .padding(12)
            }
            
            HStack {
                Text(experience.title ?? "")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                HStack {
                    Text("\(experience.likesNo ?? 0)")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .font(.caption)
                        .foregroundColor(.orange)
                }
            }
            .padding()
        }
        .padding(.horizontal)
    }
}

#Preview {
    ExperienceCard(experience: mockData)
}
