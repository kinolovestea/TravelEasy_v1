//
//  SimpleRecommendationStrategy.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//


import Foundation

struct SimpleRecommendationStrategy: RecommendationStrategy {
    func recommend(from pool: [Destination], prefs: TravelPreferences) throws -> Destination {
        let filtered = pool.filter { d in
            let tMatch = (prefs.transport == .any) || d.transportOptions.contains(prefs.transport)
            if prefs.surprise { return tMatch }
            return tMatch && d.bestFor.contains(prefs.mood!) && d.typicalBand == prefs.distance!
        }
        guard let pick = filtered.randomElement() ?? pool.randomElement() else {
            throw AppError.noMatch
        }
        return pick
    }
}
