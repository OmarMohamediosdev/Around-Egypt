//
//  ContentView.swift
//  Around Egypt
//
//  Created by Omar Mohamed on 13/10/2025.
//

import SwiftUI

struct HomeView: View {
    var recommended: [Experience] = sampleExperiences.filter { $0.isRecommended }
    var recent: [Experience] = sampleExperiences
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Search bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Try “Luxor”", text: .constant(""))
                            .textFieldStyle(PlainTextFieldStyle())
                        Spacer()
                        Image(systemName: "slider.horizontal.3")
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Welcome text
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Welcome!")
                            .font(.title2)
                            .bold()
                        Text("Now you can explore any experience in 360 degrees and get all the details about it all in one place.")
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal)
                    
                    // Recommended section
                    Text("Recommended Experiences")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(recommended) { item in
                                ExperienceCardHorizontal(experience: item)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    HomeView()
}
