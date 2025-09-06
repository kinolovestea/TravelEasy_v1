//
//  LocationView.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//

import SwiftUI

// First screen
// environment-injected RecommendationViewModel


struct LocationView: View {
    @Environment(RecommendationViewModel.self) private var vm
    @State private var cityVM = CitySearchViewModel()

    var body: some View {
        VStack(spacing: 16) {
            Text("TravelEasy").font(.largeTitle).bold()
            Text("Where do you live?").font(.title3)

            // User input; MapKit autocomplete updates automatically.
            TextField("Type your city (e.g. syd)", text: $cityVM.query)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            // suggestion list
            List(cityVM.suggestions, id: \.title) { s in
                Button {
                    cityVM.pick(s)
                } label: {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(s.title)
                        if !s.subtitle.isEmpty {
                            Text(s.subtitle)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .listStyle(.plain)

            // show the selected canonical string and proceed.
            if let chosen = cityVM.selectedCity {
                Text("Selected: \(chosen)")
                    .font(.callout)
                    .foregroundStyle(.secondary)

                NavigationLink("GO!") {
                    MoodView()
                }
                .simultaneousGesture(TapGesture().onEnded {
                    vm.prefs.city = chosen
                    vm.prefs.cityKey = cityVM.cityKey
                })
                .buttonStyle(.borderedProminent)
            }

            Spacer(minLength: 0)
        }
        .alert(cityVM.errorMessage ?? "", isPresented: Binding(
            get: { cityVM.errorMessage != nil },
            set: { _ in cityVM.errorMessage = nil })
        ) { Button("OK", role: .cancel) {} }
        .navigationBarTitleDisplayMode(.inline)
    }
}

