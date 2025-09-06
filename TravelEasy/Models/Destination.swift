//
//  Destination.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//

import Foundation

//represent a travel destination with basic metadata

struct Destination: Identifiable, Codable {
    let id: UUID
    let name: String
    let country: String
    let typicalBand: DistanceBand
    let bestFor: [Mood]
    let activities: [String]
    let avgTempC: Int
    let weatherEmoji: String
    let transportOptions: [Transport]

    init(id: UUID = UUID(), // enable decode from JSON/database later
         name: String, country: String, typicalBand: DistanceBand,
         bestFor: [Mood], activities: [String], avgTempC: Int,
         weatherEmoji: String, transportOptions: [Transport]) {
        self.id = id
        self.name = name
        self.country = country
        self.typicalBand = typicalBand
        self.bestFor = bestFor
        self.activities = activities
        self.avgTempC = avgTempC
        self.weatherEmoji = weatherEmoji
        self.transportOptions = transportOptions
    }
}

