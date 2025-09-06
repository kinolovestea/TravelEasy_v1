//
//  CitySearchViewModel.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//


import Observation
import MapKit

// Search current city using MapKit
// Keeps an internal cityKey with coordinates for future use eg weather, distance

@Observable
class CitySearchViewModel: NSObject, MKLocalSearchCompleterDelegate {
    var query: String = "" { didSet { completer.queryFragment = query } }

    var suggestions: [MKLocalSearchCompletion] = []

    var selectedCity: String? //display city, country

    var cityKey: String?

    var errorMessage: String?  //error message

    private let completer = MKLocalSearchCompleter()

    override init() {
        super.init()
        completer.delegate = self
        // Address + generic query are enough for city lookups.
        completer.resultTypes = [.address, .query]
    }

    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        suggestions = completer.results  //update list
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        errorMessage = error.localizedDescription
    }

    
    func pick(_ completion: MKLocalSearchCompletion) {
        let request = MKLocalSearch.Request(completion: completion)
        MKLocalSearch(request: request).start { [weak self] response, err in
            guard let self = self else { return }
            if let err = err {
                self.errorMessage = err.localizedDescription
                return
            }
            guard let item = response?.mapItems.first else { return }
            let pm = item.placemark

            if let city = pm.locality, let country = pm.country {
                self.selectedCity = "\(city), \(country)"
                self.cityKey = "\(city)|\(country)|\(pm.coordinate.latitude)|\(pm.coordinate.longitude)"
            } else {
                self.selectedCity = completion.title  //use suggestion
                self.cityKey = completion.title
            }
        }
    }

    func clearSelection() {
        selectedCity = nil
        cityKey = nil
    }
}


