//
//  Untitled.swift
//  Around Egypt
//
//  Created by Omar Mohamed on 14/10/2025.
//

import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var recommended: [ExperienceDatum] = []
    @Published var recent: [ExperienceDatum] = []
    @Published var searchResults: [ExperienceDatum] = []
    @Published var searchText: String = ""
    @Published var isLoading = false
    @Published var isSearching = false
    @Published var errorMessage: String?
    
    private let apiService: APIServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
        setupSearchObserver()
        fetchData()
    }

    func fetchData() {
        isLoading = true
        fetchRecommended()
        fetchRecent()
    }

    private func fetchRecommended() {
        apiService.fetchRecommendedExperiences { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.recommended = data.data ?? []
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    private func fetchRecent() {
        apiService.fetchRecentExperiences { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let data):
                    self?.recent = data.data ?? []
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    private func setupSearchObserver() {
        // Debounce to reduce API load (wait 0.5s after typing stops)
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] text in
                guard let self = self else { return }
                if text.isEmpty {
                    self.clearSearch()
                } else {
                    self.searchExperiences(text)
                }
            }
            .store(in: &cancellables)
    }
    
    func searchExperiences(_ query: String) {
        guard !query.isEmpty else { return }
        isSearching = true
        isLoading = true
        apiService.searchExperiences(query: query) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let data):
                    self?.searchResults = data.data ?? []
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func clearSearch() {
        isSearching = false
        searchResults.removeAll()
    }
    
}
