//
//  LocationView.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//

import SwiftUI

// First screen

struct LocationView: View {
    @Environment(RecommendationViewModel.self) private var vm   // ViewModel, MVVM: single source of truth
    @State private var originText: String = ""                 // Local UI state for the text field

    // parent view (ContentView) decides how to move to the next page
    let onNext: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("TravelEasy")
                .font(.largeTitle).bold()

            Text("Where do you live?")
                .font(.title3)

            // User enters a city name
            TextField("City, Country", text: $originText)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .onAppear { originText = vm.prefs.origin }  // default set to "Sydney, Australia"

            // Go button
            Button("Go!") {
                let trimmed = originText.trimmingCharacters(in: .whitespacesAndNewlines)

                // Basic validation for now:
                // -must not be empty
                // -must not be only numbers
                if trimmed.isEmpty || CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: trimmed)) {
                    vm.error = .invalidInput("Please enter a valid city name.")
                    return
                }

                // Save to ViewModel (MVVM: write data)
                vm.prefs.origin = trimmed

                // Let the parent view handle navigation (routing with Screen enum)
                onNext()
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding(.top, 32)
        // Show errors as alert (centralized error handling in AppError + ViewModel)
        .alert(item: Binding(get: { vm.error }, set: { _ in vm.error = nil })) { err in
            Alert(
                title: Text("Error"),
                message: Text(err.localizedDescription),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
