//
//  RecommendationViewModel.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//

import Observation
import Foundation


// ViewModel in MVVM: Single source of truth for the app’s recommendation flow
// Talks to Repository and Strategy
// Use @Observable so Views can automatically update when state changes


@Observable
class RecommendationViewModel {
    var prefs = TravelPreferences(origin: "Sydney, Australia")
    var recommended: Destination?
    var error: AppError?
    
    // Repository (data): follows the DestinationRepository protocol
    // Strategy (algorithm): follows the RecommendationStrategy protocol
    private let repo: DestinationRepository
    private let strategy: RecommendationStrategy
    
    init(repo: DestinationRepository = LocalDestinationRepository(),
         strategy: RecommendationStrategy = SimpleRecommendationStrategy()) {
        self.repo = repo
        self.strategy = strategy
    }
    
    
    //generate a recommendation based on current preference
    func generateRecommendation() {
        do {
            try prefs.validate()
            let dest = try strategy.recommend(from: repo.allDestinations(), prefs: prefs)
            self.recommended = dest
            self.error = nil
        } catch let appErr as AppError {
            self.error = appErr
        } catch {
            self.error = .network(error.localizedDescription)
        }
    }
    
    // go back to mood page with previous selected cleared
    func resetForEnteringMood() {
        recommended = nil
        error = nil
        prefs.mood = nil
        prefs.distance = nil
        prefs.surprise = false
    }
    
    // reserved for future extension
    func resetAllKeepingOrigin() {
        let origin = prefs.origin
        recommended = nil
        error = nil
        prefs = TravelPreferences(origin: origin)
    }
    
    // reserved for future extension
    func reset() {
        recommended = nil
        prefs = TravelPreferences()
    }
}

