//
//  RecommendationView.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//


import SwiftUI

//fourth screen to display recommendated result
struct RecommendationView: View {
    @Environment(RecommendationViewModel.self) private var vm
    
    var body: some View {
        VStack(spacing: 24) {
            if let d = vm.recommended {
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(d.name), \(d.country)").font(.title2).bold()
                    Text("\(d.weatherEmoji) \(d.avgTempC)°C")
                    Text("Perfect for \(vm.prefs.mood?.rawValue.capitalized ?? "Surprise")")
                    Text("Famous for \(d.activities.joined(separator: ", "))")
                }
                .padding()
                .background(Color.pink.opacity(0.15))
                .cornerRadius(16)
            }
            
            Button("Try another 🔄") { vm.generateRecommendation() }
                .buttonStyle(.borderedProminent)
        }
        .padding()
        .onAppear { vm.generateRecommendation() }
        .alert(item: Binding(
            get: { vm.error },
            set: { _ in vm.error = nil })
        ) { err in
            Alert(title: Text("Error"),
                  message: Text(err.localizedDescription),
                  dismissButton: .default(Text("OK")))
        }
    }
}

