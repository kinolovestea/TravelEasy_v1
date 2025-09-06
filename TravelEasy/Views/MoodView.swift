//
//  MoodView.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//


import SwiftUI

struct MoodView: View {  
    @Environment(RecommendationViewModel.self) private var vm
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Select your mood").font(.title2).bold()
            ForEach(Mood.allCases, id: \.self) { mood in
                Button(mood.rawValue.capitalized) {
                    vm.prefs.mood = mood
                }
                .frame(maxWidth: .infinity, minHeight: 60)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }
            NavigationLink("Next") { TravelPrefsView() }
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
