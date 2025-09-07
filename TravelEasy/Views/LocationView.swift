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
    @State private var originText: String = ""

    // let parent view (ContentView) decide how to proceed
    let onNext: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("TravelEasy").font(.largeTitle).bold()

            Text("Where do you live?")
                .font(.title3)

            TextField("City, Country", text: $originText)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .onAppear { originText = vm.prefs.origin }   // default “Sydney, Australia”

            Button("Go!") {
                vm.prefs.origin = originText.trimmingCharacters(in: .whitespacesAndNewlines)
                onNext()  // Let parent view drive the navigation to .mood
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding(.top, 32)
        .alert(item: Binding(get: { vm.error }, set: { _ in vm.error = nil })) { err in
            Alert(title: Text("Error"),
                  message: Text(err.localizedDescription),
                  dismissButton: .default(Text("OK")))
        }
    }
}
