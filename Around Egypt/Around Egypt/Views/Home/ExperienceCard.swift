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
    let likeAction: () -> Void
    let onSelect: () -> Void
    
    init(experience: ExperienceDatum, likeAction: @escaping () -> Void = {}, onSelect: @escaping () -> Void = {}) {
        self.experience = experience
        self.likeAction = likeAction
        self.onSelect = onSelect
    }
    
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
                                .fill(LinearGradient(colors: [.black.opacity(0.2), .black.opacity(0.4)], startPoint: .top, endPoint: .bottom))
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
                        .accessibilityIdentifier("likesLabel_\(experience.id ?? "")")
                    
                    Button(action: likeAction) {
                        Image(systemName: experience.isLiked ?? false ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .font(.caption)
                            .foregroundColor(.orange)
                            .animation(.easeInOut(duration: 0.2), value: experience.isLiked)
                        }
                        .buttonStyle(.plain)
                }
                .accessibilityIdentifier("heartButton_\(experience.id ?? "")")
            }
            .padding()
        }
        .padding(.horizontal)
        .onTapGesture { onSelect() }
        .accessibilityIdentifier("card_\(experience.id ?? "")")
    }
}

#Preview {
    ZStack {
        Color(.black).opacity(0.2).edgesIgnoringSafeArea(.all)
        ExperienceCard(experience: mockData)
    }
}
