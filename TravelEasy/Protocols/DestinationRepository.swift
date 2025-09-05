//
//  DestinationRepository.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//



// protocol for getting destination data

protocol DestinationRepository {
    func allDestinations() -> [Destination]
}
