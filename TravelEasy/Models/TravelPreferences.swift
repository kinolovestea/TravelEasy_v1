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

    
    // validate user pref before generating recommendation
    func validate() throws {
        let trimmed = origin.trimmingCharacters(in: .whitespacesAndNewlines)

        // Origin city cannot be empty or numeric only
        if trimmed.isEmpty || CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: trimmed)) {
            throw AppError.invalidInput("Please enter a valid city name.")
        }

        // Fallback plan
        if !surprise && (mood == nil || distance == nil) {
            throw AppError.invalidInput("Please choose your mood and distance, or tap Surprise me.")
        }
    }
}


// Mood categories
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

// Travel distance range
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

// Transport methods
enum Transport: String, CaseIterable, Codable {
    case plane, train, any
}


