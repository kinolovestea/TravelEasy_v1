//
//  RecommendationStrategy.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//


// protocol for generating travel recommendations
protocol RecommendationStrategy {
    func recommend(from pool: [Destination], prefs: TravelPreferences) throws -> Destination
}

