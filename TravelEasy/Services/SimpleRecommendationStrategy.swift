//
//  SimpleRecommendationStrategy.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//


import Foundation

// simple strategy that picks one destination based on mood and distance
// conforms to RecommendationStrategy protocol

struct SimpleRecommendationStrategy: RecommendationStrategy {
    func recommend(from pool: [Destination], prefs: TravelPreferences) throws -> Destination {
        // filter by mood
        let moodFiltered = prefs.mood.map { m in pool.filter { $0.bestFor.contains(m) } } ?? pool
        // choose distance, if surprise mode: pick a random
        let band: DistanceBand? = prefs.surprise ? [DistanceBand.h1_2, .h3_5, .h5_plus].randomElement() : prefs.distance
        // filter the moodFiltered list by the chosen distance band.
        let final = band.map { b in moodFiltered.filter { $0.typicalBand == b } } ?? moodFiltered
        // pick a random destination from the filtered list
        guard let pick = final.randomElement() else {
            throw AppError.noMatch  // throw error if no matching found
        }
        return pick
    }
}

