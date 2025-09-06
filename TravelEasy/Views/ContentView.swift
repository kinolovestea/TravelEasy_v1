//
//  ContentView.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//

import SwiftUI


// hosts NavigationStack and shows the first screen
struct ContentView: View {
    var body: some View {
        NavigationStack {
            LocationView()
        }
    }
}

#Preview {
    ContentView()
        .environment(RecommendationViewModel())
}


