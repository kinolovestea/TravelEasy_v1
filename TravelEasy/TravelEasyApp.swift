//
//  TravelEasyApp.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//

import SwiftUI

@main
struct TravelEasyApp: App {
    @State private var vm = RecommendationViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(vm) // Inject ViewModel into environment
        }
    }
}

