//
//  RecommendationViewModel.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//

import Observation
import Foundation


// main app viewModel

@Observable
class RecommendationViewModel {
    var prefs = TravelPreferences()
    var recommended: Destination?
    var error: AppError?
    
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
    
    
    //reset pref to start over
    func reset() {
        recommended = nil
        prefs = TravelPreferences()
    }
    
}
