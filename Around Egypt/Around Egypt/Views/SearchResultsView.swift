//
//  SearchResultsView.swift
//  Around Egypt
//
//  Created by Omar Mohamed on 15/10/2025.
//

import SwiftUI

struct SearchResultsView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView().padding()
            } else if viewModel.searchResults.isEmpty {
                Text("No results found.")
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                VStack(spacing: 16) {
                    ForEach(viewModel.searchResults) { exp in
                        ExperienceCard(experience: exp)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    SearchResultsView(viewModel: HomeViewModel())
}
