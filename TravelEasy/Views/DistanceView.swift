//
//  Untitled 2.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//

import SwiftUI

// third screen to select distance wanted
struct DistanceView: View {
    @Environment(RecommendationViewModel.self) private var vm
    private let bands: [DistanceBand] = [.h1_2, .h3_5, .h5_plus]

    var body: some View {
        VStack(spacing: 16) {
            Text("How far are you willing to go?")
                .font(.title3).bold()

            ForEach(bands, id: \.self) { band in
                NavigationLink {
                    RecommendationView()
                } label: {
                    Text(band.title)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .buttonStyle(.plain)
                .simultaneousGesture(
                    TapGesture().onEnded {
                        vm.prefs.distance = band
                        vm.prefs.surprise = false
                        vm.generateRecommendation()
                    }
                )
            }

            Spacer()

            NavigationLink {
                RecommendationView()
            } label: {
                Text("Surprise me!")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.red)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .buttonStyle(.plain)
            .simultaneousGesture(
                TapGesture().onEnded {
                    vm.prefs.surprise = true
                    vm.generateRecommendation()
                }
            )
        }
        .padding()
    }
}
