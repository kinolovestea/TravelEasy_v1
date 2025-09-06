//
//  LocalDestinationRepository.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//



// multiple sample destinations
// with switch to CoreData or cloud database in the next assignment

struct LocalDestinationRepository: DestinationRepository {
    func allDestinations() -> [Destination] {
        return [
            Destination(name: "Cairns", country: "Australia",
                        typicalBand: .h1_2, bestFor: [.chill],
                        activities: ["Great Barrier Reef", "Waterfall hiking", "Surfing"],
                        avgTempC: 27, weatherEmoji: "☀️",
                        transportOptions: [.plane]),
            
            Destination(name: "Canterbury", country: "New Zealand",
                        typicalBand: .h3_5, bestFor: [.adventurous],
                        activities: ["Christchurch City", "Mount Cook National Park", "Lake Tekapo"],
                        avgTempC: 15, weatherEmoji: "⛅️",
                        transportOptions: [.plane]),
            
            Destination(name: "Barcelona", country: "Spain",
                        typicalBand: .h5_plus, bestFor: [.vibrant],
                        activities: ["Sagrada Familia", "Beaches", "Tapas tour"],
                        avgTempC: 22, weatherEmoji: "☀️",
                        transportOptions: [.plane]),
            
            Destination(name: "Shanghai", country: "China",
                        typicalBand: .h5_plus, bestFor: [.vibrant],
                        activities: ["The Bund", "Disneyland", "Nanjing Road"],
                        avgTempC: 20, weatherEmoji: "🌤",
                        transportOptions: [.plane]),
            
            Destination(name: "Bali", country: "Indonesia",
                        typicalBand: .h5_plus, bestFor: [.chill, .peaceful],
                        activities: ["Beaches", "Ubud Rice Terraces", "Surfing"],
                        avgTempC: 29, weatherEmoji: "🌴",
                        transportOptions: [.plane]),
            
            Destination(name: "Melbourne", country: "Australia",
                        typicalBand: .h1_2, bestFor: [.vibrant],
                        activities: ["Great Ocean Road", "Coffee culture", "Art laneways"],
                        avgTempC: 18, weatherEmoji: "☁️",
                        transportOptions: [.plane, .train]),
            
            Destination(name: "Perth", country: "Australia",
                        typicalBand: .h3_5, bestFor: [.chill],
                        activities: ["Cottesloe Beach", "Rottnest Island", "Kings Park"],
                        avgTempC: 23, weatherEmoji: "☀️",
                        transportOptions: [.plane]),
            
            Destination(name: "Honolulu", country: "United States",
                        typicalBand: .h5_plus, bestFor: [.chill, .peaceful],
                        activities: ["Waikiki Beach", "Pearl Harbor", "Diamond Head"],
                        avgTempC: 28, weatherEmoji: "🌴",
                        transportOptions: [.plane]),
            
            Destination(name: "Los Angeles", country: "United States",
                        typicalBand: .h5_plus, bestFor: [.chill, .vibrant],
                        activities: ["Hollywood", "Santa Monica", "Disneyland"],
                        avgTempC: 24, weatherEmoji: "☀️",
                        transportOptions: [.plane]),
            
            Destination(name: "Paris", country: "France",
                        typicalBand: .h5_plus, bestFor: [.vibrant],
                        activities: ["Eiffel Tower", "Louvre Museum", "Seine River cruise"],
                        avgTempC: 17, weatherEmoji: "☁️",
                        transportOptions: [.plane])
        ]
    }
}

