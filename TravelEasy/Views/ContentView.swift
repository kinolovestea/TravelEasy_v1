//
//  ContentView.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//

import SwiftUI

struct ContentView: View {
    @State private var path: [Screen] = [.location]
    @Environment(RecommendationViewModel.self) private var vm

    var body: some View {
        NavigationStack(path: $path) {
            LocationView(onNext: { path.append(.mood) })
                .navigationDestination(for: Screen.self) { screen in
                    switch screen {
                    case .location:
                        LocationView(onNext: { path.append(.mood) })
                    case .mood:
                        MoodView(
                            onPick: { _ in path.append(.distance) },
                            onAppearReset: { vm.resetForEnteringMood() }   // always enter Mood fresh
                        )
                    case .distance:
                        DistanceView(generateAndGo: {
                            vm.generateRecommendation()
                            if vm.recommended != nil { path.append(.recommendation) }
                        })
                    case .recommendation:
                        RecommendationView(tryAnother: {
                            vm.resetForEnteringMood()
                            path = [.mood]
                        })
                    }
                }
        }
    }
}

#Preview {
    ContentView()
        .environment(RecommendationViewModel())
}
