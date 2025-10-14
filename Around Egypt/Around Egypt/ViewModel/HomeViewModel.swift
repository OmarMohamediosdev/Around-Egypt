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
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
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

//    func likeExperience(_ experience: ExperienceDatum) {
//        apiService.likeExperience(id: experience.id ?? "") { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let updated):
//                    if let index = self?.recent.firstIndex(where: { $0.id == updated.id }) {
//                        self?.recent[index] = updated
//                    }
//                    if let index = self?.recommended.firstIndex(where: { $0.id == updated.id }) {
//                        self?.recommended[index] = updated
//                    }
//                case .failure(let error):
//                    self?.errorMessage = error.localizedDescription
//                }
//            }
//        }
//    }
}
