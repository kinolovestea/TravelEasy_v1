//
//  SimpleRecommendationStrategy.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//


import Foundation

// tiny testable strategy that matches user's mood and prefered distance.
// if "surprise me" is on, distance is randomized but mood is kept

struct SimpleRecommendationStrategy: RecommendationStrategy {
    func recommend(from pool: [Destination], prefs: TravelPreferences) throws -> Destination {
        let moodFiltered = prefs.mood.map { m in pool.filter { $0.bestFor.contains(m) } } ?? pool
        let band: DistanceBand? = prefs.surprise ? [DistanceBand.h1_2, .h3_5, .h5_plus].randomElement() : prefs.distance
        let final = band.map { b in moodFiltered.filter { $0.typicalBand == b } } ?? moodFiltered
        guard let pick = final.randomElement() else {
            throw AppError.noMatch
        }
        return pick
    }
}
