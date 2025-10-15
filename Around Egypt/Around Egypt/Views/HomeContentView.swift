//
//  HomeContentView.swift
//  Around Egypt
//
//  Created by Omar Mohamed on 15/10/2025.
//

import SwiftUI

struct HomeContentView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // Welcome text
                VStack(alignment: .leading, spacing: 4) {
                    Text("Welcome!")
                        .font(.title2)
                        .bold()
                    Text("Now you can explore any experience in 360 degrees and get all the details about it all in one place.")
                        .font(.subheadline)
                }
                .padding(.leading)
                
                // Recommended section
                VStack(alignment: .leading, spacing: 5) {
                    Text("Recommended Experiences")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    if viewModel.isLoading {
                        ProgressView().padding()
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(viewModel.recommended) { exp in
                                    ExperienceCard(experience: exp)
                                        .frame(width: 390, height: .infinity)
                                }
                            }
                        }
                    }
                    
                }
                
                // Recent section
                VStack(alignment: .leading, spacing: 5) {
                    Text("Most Recent")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.leading, 25)
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 16) {
                            ForEach(viewModel.recent) { exp in
                                ExperienceCard(experience: exp)
                            }
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    HomeContentView(viewModel: HomeViewModel())
}
