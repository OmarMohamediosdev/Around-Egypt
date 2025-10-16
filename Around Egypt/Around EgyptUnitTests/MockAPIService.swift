//
//  MockAPIService.swift
//  Around EgyptUnitTests
//
//  Created by Omar Mohamed on 16/10/2025.
//

import Foundation
@testable import Around_Egypt // allows tests to access internal classes

final class MockAPIService: APIServiceProtocol {
    var recommendedResponse: Experience?
    var recentResponse: Experience?
    var searchResponse: Experience?
    var likeResponse: Experience?

    var fetchRecommendedCalled = false
    var fetchRecentCalled = false
    var searchCalledWith: String?
    var likeCalledWith: String?

    func fetchRecommendedExperiences(completion: @escaping (Result<Experience, Error>) -> Void) {
        fetchRecommendedCalled = true
        if let data = recommendedResponse {
            completion(.success(data))
        } else {
            completion(.failure(NSError(domain: "mock", code: 1)))
        }
    }

    func fetchRecentExperiences(completion: @escaping (Result<Experience, Error>) -> Void) {
        fetchRecentCalled = true
        if let data = recentResponse {
            completion(.success(data))
        } else {
            completion(.failure(NSError(domain: "mock", code: 2)))
        }
    }

    func likeExperience(id: String, completion: @escaping (Result<Experience, Error>) -> Void) {
        likeCalledWith = id
        if let data = likeResponse {
            completion(.success(data))
        } else {
            completion(.failure(NSError(domain: "mock", code: 3)))
        }
    }

    func searchExperiences(query: String, completion: @escaping (Result<Experience, Error>) -> Void) {
        searchCalledWith = query
        if let data = searchResponse {
            completion(.success(data))
        } else {
            completion(.failure(NSError(domain: "mock", code: 4)))
        }
    }
}
