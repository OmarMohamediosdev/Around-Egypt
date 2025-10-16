//
//  HomeViewModelTests.swift
//  Around EgyptUnitTests
//
//  Created by Omar Mohamed on 16/10/2025.
//

import XCTest
@testable import Around_Egypt

@MainActor
final class HomeViewModelTests: XCTestCase {
    var sut: HomeViewModel!     // system under test
    var mockService: MockAPIService!

    override func setUp() {
        super.setUp()
        mockService = MockAPIService()
        sut = HomeViewModel(apiService: mockService)
    }

    override func tearDown() {
        sut = nil
        mockService = nil
        super.tearDown()
    }
    
    @MainActor func test_fetchData_populatesRecommendedAndRecent() {
        // Given: fake data
        let datum = ExperienceDatum(
            id: "1",
            title: "Pyramids",
            coverPhoto: nil,
            description: nil,
            viewsNo: 100,
            recommended: 1,
            city: nil,
            likesNo: 5,
            isLiked: false
        )
        let experience = Experience(data: [datum])
        mockService.recommendedResponse = experience
        mockService.recentResponse = experience

        // When
        sut.fetchData()

        // Then
        let exp = expectation(description: "Wait for async completion")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            XCTAssertEqual(self.sut.recommended.count, 1)
            XCTAssertEqual(self.sut.recent.count, 1)
            XCTAssertTrue(self.mockService.fetchRecommendedCalled)
            XCTAssertTrue(self.mockService.fetchRecentCalled)
            exp.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
    
    @MainActor func test_likeExperience_updatesLocalAndCallsAPI() {
        // Given
        let datum = ExperienceDatum(
            id: "100",
            title: "Aswan",
            coverPhoto: nil,
            description: nil,
            viewsNo: 0,
            recommended: 0,
            city: nil,
            likesNo: 1,
            isLiked: false
        )
        sut.recent = [datum] // simulate existing data
        
        let updatedDatum = ExperienceDatum(
            id: "100",
            title: "Aswan",
            coverPhoto: nil,
            description: nil,
            viewsNo: 0,
            recommended: 0,
            city: nil,
            likesNo: 2,
            isLiked: true
        )
        mockService.likeResponse = Experience(data: [updatedDatum])

        // When
        sut.likeExperience(datum)

        // Then
        XCTAssertEqual(sut.recent.first?.isLiked, true)
        XCTAssertEqual(sut.recent.first?.likesNo, 2)
        XCTAssertEqual(mockService.likeCalledWith, "100")
    }
    
    @MainActor func test_searchExperiences_returnsResults() {
        // Given
        let datum = ExperienceDatum(
            id: "200",
            title: "Luxor",
            coverPhoto: nil,
            description: nil,
            viewsNo: 0,
            recommended: 0,
            city: nil,
            likesNo: 0,
            isLiked: false
        )
        mockService.searchResponse = Experience(data: [datum])

        // When
        sut.searchExperiences("Luxor")

        // Then
        let exp = expectation(description: "search results")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            XCTAssertEqual(self.sut.searchResults.first?.title, "Luxor")
            XCTAssertEqual(self.mockService.searchCalledWith, "Luxor")
            exp.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    @MainActor func test_loadCachedData_loadsFilesIfTheyExist() {
        let datum = ExperienceDatum(
            id: "300",
            title: "Abu Simbel",
            coverPhoto: nil,
            description: nil,
            viewsNo: 0,
            recommended: 1,
            city: nil,
            likesNo: 0,
            isLiked: false
        )
        let experience = Experience(data: [datum])
        CacheManager.shared.save(experience, to: "recommended_cache.json")
        CacheManager.shared.save(experience, to: "recent_cache.json")

        // When
        sut = HomeViewModel(apiService: mockService)
        // Then
        XCTAssertEqual(sut.recommended.first?.id, "300")
        XCTAssertEqual(sut.recent.first?.id, "300")
    }

}
