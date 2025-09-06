//
//  TravelPreferences.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//

import Foundation

//store user-selected preference

struct TravelPreferences {
    var city: String?
    var cityKey: String?
    var mood: Mood?
    var distance: DistanceBand?
    var transport: Transport = .any
    var surprise: Bool = false

    func validate() throws {
        if city?.isEmpty ?? true {
            throw AppError.invalidInput("Please choose your location.")
        }
        if !surprise && (mood == nil || distance == nil) {
            throw AppError.invalidInput("Please complete mood and distance.")
        }
    }
}

// user mood catogories
enum Mood: String, CaseIterable, Codable {
    case chill, adventurous, peaceful, vibrant
}

// travel distance range
enum DistanceBand: String, CaseIterable, Codable {
    case h1_2, h3_5, h5_plus
}

// transport methods
enum Transport: String, CaseIterable, Codable {
    case plane, train, any
}

