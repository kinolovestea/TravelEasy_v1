//
//  Untitled 2.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//

import SwiftUI

//third screen for selecting distance and transport methods
struct TravelPrefsView: View {
    @Environment(RecommendationViewModel.self) private var vm
    
    var body: some View {
        VStack(spacing: 20) {
            Text("How far are you willing to go?").font(.title3).bold()
            
            HStack {
                PrefButton(title: "✈️ 1–2 hours") { vm.prefs.distance = .h1_2 }
                PrefButton(title: "✈️ 3–5 hours") { vm.prefs.distance = .h3_5 }
                PrefButton(title: "✈️ 5+ hours") { vm.prefs.distance = .h5_plus }
            }
            
            HStack {
                Button("By train") { vm.prefs.transport = .train }
                Button("Surprise Me!") { vm.prefs.surprise = true }
            }
            
            NavigationLink("See destination") { RecommendationView() }
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
