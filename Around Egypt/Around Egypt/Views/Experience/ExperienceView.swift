//
//  ExperienceView.swift
//  Around Egypt
//
//  Created by Omar Mohamed on 15/10/2025.
//

import SwiftUI
import Kingfisher

struct ExperienceView: View {
    @ObservedObject var viewModel: HomeViewModel
    let experienceID: String
    
    // Always return the latest copy from ViewModel
    private var experience: ExperienceDatum? {
        viewModel.allExperiences.first(where: { $0.id == experienceID })
    }
    
    var body: some View {
        if let experience = experience {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    
                    // MARK: - Header Image
                    ExperienceHeader(experience: experience)
                    
                    // MARK: - Details Section
                    VStack(alignment: .leading, spacing: 8) {
                        
                        HStack(alignment: .top) {
                            // Title
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
                            
                            HStack(spacing: 16) {
                                // Share
                                Button(action: {
                                    // TODO: Share functionality
                                }) {
                                    Image(systemName: "square.and.arrow.up")
                                        .foregroundColor(.orange)
                                }
                                
                                // like
                                Button(action: {
                                    viewModel.likeExperience(experience)
                                }) {
                                    HStack(spacing: 4) {
                                        Image(systemName: experience.isLiked ?? false ? "heart.fill" : "heart")
                                            .foregroundColor(.orange)
                                            .accessibilityIdentifier("sheetHeart_\(experience.id ?? "")")
                                        
                                        Text("\(experience.likesNo ?? 0)")
                                            .foregroundColor(.primary)
                                            .accessibilityIdentifier("sheetLikesLabel_\(experience.id ?? "")")
                                    }
                                }
                                .buttonStyle(.plain)
                            }
                            .font(.title2)
                        }
                        .padding(.horizontal)
                        .padding(.top, 16)
                        
                        Divider()
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                        
                        // Description
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
            .presentationDetents([.fraction(0.7), .large])
            .presentationDragIndicator(.visible)
        } else {
            ProgressView("Loading…")
                .presentationDetents([.fraction(0.3)])
        }
    }
}

#Preview {
    ExperienceView(viewModel: HomeViewModel(), experienceID: "")
}
