//
//  RecommendationView.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//


import SwiftUI

// Fourth screen to display recommendated result
struct RecommendationView: View {
    @Environment(RecommendationViewModel.self) private var vm

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let d = vm.recommended {
                Text("Your perfect destination").font(.title2).bold()

                VStack(alignment: .leading, spacing: 8) {
                    Text("\(d.name), \(d.country)")
                        .font(.title3).bold()
                    
                    Text(hoursLine(for: d))
                        .foregroundStyle(.secondary)

                    Text("Perfect for \(vm.prefs.mood?.title ?? "you")")
                        .padding(.top, 6)

                    Text("Famous for \(d.activities.joined(separator: ", "))")
                        .foregroundStyle(.secondary)
                }
                .padding()
                .background(Color.pink.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 12))

                // weather not shown, will add weather api in the next assignment
                
                NavigationLink("Try another") {
                    MoodView()
                }
                .simultaneousGesture(
                    TapGesture().onEnded {
                        vm.resetToMood()
                    }
                )
                .buttonStyle(.bordered)
                .padding(.top, 8)

                Spacer()
            } else {
                Text("No recommendation yet.")
                Spacer()
            }
        }
        .padding()
        .alert(item: Binding(get: { vm.error }, set: { _ in vm.error = nil })) { err in
            Alert(title: Text("Error"),
                  message: Text(err.localizedDescription),
                  dismissButton: .default(Text("OK")))
        }
    }

    private func hoursLine(for d: Destination) -> String {
        switch d.typicalBand {
        case .h1_2: return "Approx. 1–2 hour flight"
        case .h3_5: return "Approx. 3–5 hour flight"
        case .h5_plus: return "Approx. 5+ hour flight"
        }
    }
}
