//
//  TravelEasyTests.swift
//  TravelEasyTests
//
//  Created by Yu on 9/8/25.
//


import XCTest
@testable import TravelEasy


private extension Destination {
    static func make(
        name: String,
        country: String = "Test",
        band: DistanceBand,
        bestFor: [Mood]
    ) -> Destination {
        Destination(
            name: name,
            country: country,
            typicalBand: band,
            bestFor: bestFor,
            activities: ["Test"],
            avgTempC: 20,
            weatherEmoji: "",
            transportOptions: [.plane]
        )
    }
}


final class TravelEasyCoreTests: XCTestCase {

    // 1. Strategy returns correct match (mood + distance)

    func testStrategy_ReturnsMatch_ForMoodAndDistance() throws {
        // Arrange
        let pool: [Destination] = [
            .make(name: "A", band: .h1_2, bestFor: [.chill]),
            .make(name: "B", band: .h3_5, bestFor: [.adventurous]),
            .make(name: "C", band: .h1_2, bestFor: [.chill, .peaceful]),
        ]
        var prefs = TravelPreferences(origin: "Sydney, Australia")
        prefs.mood = .chill
        prefs.distance = .h1_2
        prefs.surprise = false

        let strategy = SimpleRecommendationStrategy()

        // Act
        let dest = try strategy.recommend(from: pool, prefs: prefs)

        // Assert
        XCTAssertTrue(dest.bestFor.contains(.chill))
        XCTAssertEqual(dest.typicalBand, .h1_2)
    }

    
    // 2. Invalid input: empty or digit-only origin

    func testValidate_EmptyOrigin_ThrowsInvalidInput() {
        var prefs = TravelPreferences(origin: "")
        prefs.mood = .chill
        prefs.distance = .h1_2

        XCTAssertThrowsError(try prefs.validate()) { error in
            guard case AppError.invalidInput(let msg) = error else {
                return XCTFail("Expected AppError.invalidInput, got \(error)")
            }
            XCTAssertEqual(msg, "Please enter a valid city name.")
        }
    }

    func testValidate_DigitsOnlyOrigin_ThrowsInvalidInput() {
        var prefs = TravelPreferences(origin: "12345")
        prefs.mood = .chill
        prefs.distance = .h1_2

        XCTAssertThrowsError(try prefs.validate()) { error in
            guard case AppError.invalidInput(let msg) = error else {
                return XCTFail("Expected AppError.invalidInput, got \(error)")
            }
            XCTAssertEqual(msg, "Please enter a valid city name.")
        }
    }

    // 3. No match case triggers AppError.noMatch

    func testStrategy_NoMatch_ThrowsNoMatch() {
        // Arrange: pool has only adventurous 5+ hours
        let pool: [Destination] = [
            .make(name: "X", band: .h5_plus, bestFor: [.adventurous])
        ]
        var prefs = TravelPreferences(origin: "Sydney, Australia")
        prefs.mood = .chill
        prefs.distance = .h1_2
        let strategy = SimpleRecommendationStrategy()

        // Act + Assert
        XCTAssertThrowsError(try strategy.recommend(from: pool, prefs: prefs)) { error in
            XCTAssertTrue(error is AppError)
            if case AppError.noMatch = error {
                // ok
            } else {
                XCTFail("Expected AppError.noMatch, got \(error)")
            }
        }
    }

    // 4. ViewModel successfully gives recommendation & clears error

    func testViewModel_GenerateRecommendation_SetsRecommended() {
        let pool: [Destination] = [
            .make(name: "C1", band: .h1_2, bestFor: [.chill]),
            .make(name: "C2", band: .h1_2, bestFor: [.chill]),
        ]

        // A tiny in-memory repo to isolate the test
        struct InMemoryRepo: DestinationRepository {
            let data: [Destination]
            func allDestinations() -> [Destination] { data }
        }

        let vm = RecommendationViewModel(
            repo: InMemoryRepo(data: pool),
            strategy: SimpleRecommendationStrategy()
        )
        vm.prefs.origin = "Sydney, Australia"
        vm.prefs.mood = .chill
        vm.prefs.distance = .h1_2

        // Act
        vm.generateRecommendation()

        // Assert
        XCTAssertNotNil(vm.recommended)
        XCTAssertNil(vm.error)
        XCTAssertEqual(vm.recommended?.typicalBand, .h1_2)
        XCTAssertTrue(vm.recommended?.bestFor.contains(.chill) ?? false)
    }

    
    // 5. ViewModel: invalid input populates error and not recommended
    
    func testViewModel_InvalidInput_PopulatesError() {
        // digits-only origin should fail validate()
        struct EmptyRepo: DestinationRepository { func allDestinations() -> [Destination] { [] } }

        let vm = RecommendationViewModel(
            repo: EmptyRepo(),
            strategy: SimpleRecommendationStrategy()
        )
        vm.prefs.origin = "12345"
        vm.prefs.mood = .chill
        vm.prefs.distance = .h1_2

        // Act
        vm.generateRecommendation()

        // Assert
        XCTAssertNil(vm.recommended)
        guard case AppError.invalidInput(let msg)? = vm.error else {
            return XCTFail("Expected AppError.invalidInput, got \(String(describing: vm.error))")
        }
        XCTAssertEqual(msg, "Please enter a valid city name.")
    }

    
    // 6. ViewModel: resetForEnteringMood clears mood/distance/recommended/error but keeps origin city input

    func testViewModel_ResetForEnteringMood_ClearsExpectedFields() {
        // Arrange
        struct EmptyRepo: DestinationRepository { func allDestinations() -> [Destination] { [] } }
        let vm = RecommendationViewModel(repo: EmptyRepo(), strategy: SimpleRecommendationStrategy())
        vm.prefs.origin = "Sydney, Australia"
        vm.prefs.mood = .chill
        vm.prefs.distance = .h3_5
        vm.prefs.surprise = true
        vm.error = .noMatch
        vm.recommended = .make(name: "Temp", band: .h1_2, bestFor: [.chill])
        vm.resetForEnteringMood()

        // Assert
        XCTAssertEqual(vm.prefs.origin, "Sydney, Australia")
        XCTAssertNil(vm.prefs.mood)
        XCTAssertNil(vm.prefs.distance)
        XCTAssertFalse(vm.prefs.surprise)
        XCTAssertNil(vm.recommended)
        XCTAssertNil(vm.error)
    }
}
