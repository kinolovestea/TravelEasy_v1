//
//  RecommendationStrategy.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//


// protocol for returning one recommended destination from the given pool
protocol RecommendationStrategy {
    func recommend(from pool: [Destination], prefs: TravelPreferences) throws -> Destination
}

