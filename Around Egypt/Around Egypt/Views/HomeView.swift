//
//  ContentView.swift
//  Around Egypt
//
//  Created by Omar Mohamed on 13/10/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Search bar
                    HStack {
                        Spacer()
                        
                        Image(systemName: "line.3.horizontal")
                        
                        HStack {
                            Image(systemName: "magnifyingglass")
                            TextField("Try “Luxor”", text: .constant(""))
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding()
                        }
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        
                        Image(systemName: "slider.horizontal.3")
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                    // Welcome text
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Welcome!")
                            .font(.title2)
                            .bold()
                        Text("Now you can explore any experience in 360 degrees and get all the details about it all in one place.")
                            .font(.subheadline)
                    }
                    .padding(.leading, 25)
                    
                    // Recommended section
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Recommended Experiences")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        if viewModel.isLoading {
                            ProgressView().padding()
                        } else {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(viewModel.recommended) { exp in
                                        ExperienceCard(experience: exp)
                                    }
                                }
                            }
                        }
                        
                    }
                    .padding(.horizontal, 25)
                    
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
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    HomeView()
}
