//
//  DestinationRepository.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//


// protocol for reading destination data (data source layer)
protocol DestinationRepository {
    func allDestinations() -> [Destination]
}
