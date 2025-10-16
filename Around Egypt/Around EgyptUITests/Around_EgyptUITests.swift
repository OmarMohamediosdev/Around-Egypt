//
//  Around_EgyptUITests.swift
//  Around EgyptUITests
//
//  Created by Omar Mohamed on 16/10/2025.
//

import XCTest

final class Around_EgyptUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func test_search_showsResults() throws {
        // Find the search field and type text
        let searchField = app.textFields["searchTextField"]
        XCTAssertTrue(searchField.waitForExistence(timeout: 3))
        searchField.tap()
        searchField.typeText("Luxor")

        // Wait a bit for search results to load
        sleep(2)

        // Expect at least one card appears
        let card = app.otherElements.containing(NSPredicate(format: "identifier BEGINSWITH 'card_'")).firstMatch
        XCTAssertTrue(card.exists, "A search result card should appear")
    }

    func test_like_in_sheet_increases_count() throws {
        // Tap first card
        let firstCard = app.otherElements.containing(NSPredicate(format: "identifier BEGINSWITH 'card_'")).firstMatch
        XCTAssertTrue(firstCard.waitForExistence(timeout: 5))
        firstCard.tap()

        // Wait for sheet to appear
        let sheetHeart = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH 'sheetHeart_'")).firstMatch
        XCTAssertTrue(sheetHeart.waitForExistence(timeout: 5))

        let likesLabel = app.staticTexts.matching(NSPredicate(format: "identifier BEGINSWITH 'sheetLikesLabel_'")).firstMatch
        let beforeCount = Int(likesLabel.label) ?? -1

        // Tap heart button
        sheetHeart.tap()
        sleep(1)

        let afterCount = Int(likesLabel.label) ?? -1
        XCTAssertTrue(afterCount >= beforeCount + 1, "Likes should increase after tapping heart")
    }
}
