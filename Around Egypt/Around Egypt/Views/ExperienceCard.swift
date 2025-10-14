//
//  ExperienceCardHorizontal.swift
//  Around Egypt
//
//  Created by Omar Mohamed on 14/10/2025.
//

import SwiftUI

struct ExperienceCard: View {
    let experience: Experience
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                Image(experience.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: .infinity, height: 180)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(LinearGradient(colors: [.clear, .black.opacity(0.4)], startPoint: .top, endPoint: .bottom))
                    )
                    .overlay(
                        Image("circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .tint(Color.white)
                            .overlay(
                                Text("360")
                                    .foregroundColor(.white)
                            )
                    )
                
                VStack(alignment: .leading) {
                    HStack {
                        if experience.isRecommended {
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
                        Label("\(experience.views)", systemImage: "eye")
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
                Text(experience.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Label("\(experience.likes)", systemImage: "heart.fill")
                    .font(.caption)
                    .foregroundColor(.orange)
            }
            .padding()
        }
        
    }
}

#Preview {
    ExperienceCard(experience: sampleExperiences[0])
}
