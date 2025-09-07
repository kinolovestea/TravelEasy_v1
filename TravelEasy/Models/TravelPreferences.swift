//
//  TravelPreferences.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//

import Foundation

//store user-selected preference

struct TravelPreferences: Codable {
    var origin: String = "Sydney, Australia"
    var mood: Mood?
    var distance: DistanceBand?
    var surprise: Bool = false
    var transport: Transport = .plane

    func validate() throws {
        if origin.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw AppError.invalidInput("Please enter your current city.")
        }
        if !surprise && (mood == nil || distance == nil) {
            throw AppError.invalidInput("Please choose your mood and distance, or tap Surprise me.")
        }
    }
}


// user mood catogories
enum Mood: String, CaseIterable, Codable {
    case chill, adventurous, peaceful, vibrant
    var title: String { rawValue.capitalized }
    var emoji: String {
        switch self {
        case .chill: return "🏖️"
        case .adventurous: return "⛰️"
        case .peaceful: return "😌"
        case .vibrant: return "🥳"
        }
    }
}


// travel distance range
enum DistanceBand: String, CaseIterable, Codable {
    case h1_2, h3_5, h5_plus
    var title: String {
        switch self {
        case .h1_2: return "✈️ 1–2 hours"
        case .h3_5: return "✈️ 3–5 hours"
        case .h5_plus: return "✈️ 5+ hours"
        }
    }
}


// transport methods
enum Transport: String, CaseIterable, Codable {
    case plane, train, any
}

