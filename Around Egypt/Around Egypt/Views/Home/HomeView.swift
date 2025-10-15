//
//  ContentView.swift
//  Around Egypt
//
//  Created by Omar Mohamed on 13/10/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var selectedExperience: ExperienceDatum?
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
                            
                            TextField("Try “Luxor”", text: $viewModel.searchText, onCommit: {
                                if !searchText.isEmpty {
                                    viewModel.searchExperiences(searchText)
                                }
                            })
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            
                            if !viewModel.searchText.isEmpty {
                                Button(action: {
                                    viewModel.clearSearch()
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                                .transition(.opacity)
                                .animation(.easeInOut(duration: 0.2), value: viewModel.searchText)
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        
                        Image(systemName: "slider.horizontal.3")
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // Body
                    if viewModel.isSearching {
                        SearchResultsView(viewModel: viewModel, selectedExperience: $selectedExperience)
                    } else {
                        HomeContentView(viewModel: viewModel, selectedExperience: $selectedExperience)
                    }
                    
                }
            }
            .sheet(item: $selectedExperience) { experience in
                ExperienceView(experience: experience)
                    .presentationDetents([.fraction(1), .large])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

#Preview {
    HomeView()
}
