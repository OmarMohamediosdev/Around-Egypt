//
//  ExperienceView.swift
//  Around Egypt
//
//  Created by Omar Mohamed on 15/10/2025.
//

import SwiftUI
import Kingfisher

struct ExperienceView: View {
    let experience: ExperienceDatum
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                
                // MARK: - Header Image
                ExperienceHeader(experience: experience)
                
                // MARK: - Details Section
                VStack(alignment: .leading, spacing: 8) {
                    // Title
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(experience.title ?? "Experience")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                            if let city = experience.city?.name {
                                Text(city)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        Spacer()
                        
                        // like + share
                        HStack(spacing: 12) {
                            Button(action: {
                                // TODO: Share functionality
                            }) {
                                Image(systemName: "square.and.arrow.up")
                                    .foregroundColor(.orange)
                            }
                            
                            HStack(spacing: 4) {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.orange)
                                Text("\(experience.likesNo ?? 0)")
                                    .foregroundColor(.primary)
                            }
                        }
                        .font(.title2)
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)
                    
                    Divider()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                    
                    // Description Section
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Description")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Text(experience.description ?? "No description available.")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineSpacing(4)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                }
            }
        }
        // Sheet-style presentation
        .presentationDetents([.fraction(0.7), .large])
        .presentationDragIndicator(.visible)
    }
    
}

#Preview {
    ExperienceView(experience: mockData)
}
