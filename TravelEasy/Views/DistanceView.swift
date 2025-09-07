//
//  DistanceView.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//


import SwiftUI

// third screen to select distance wanted
struct DistanceView: View {
    @Environment(RecommendationViewModel.self) private var vm
    let generateAndGo: () -> Void

    private let bands: [DistanceBand] = [.h1_2, .h3_5, .h5_plus]

    var body: some View {
        VStack(spacing: 16) {
            Text("How far are you willing to go?")
                .font(.title3).bold()

            ForEach(bands, id: \.self) { band in
                Button {
                    vm.prefs.distance = band
                    vm.prefs.surprise = false
                    generateAndGo()     //only jump to next page if matching data found
                } label: {
                    Text(band.title)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .buttonStyle(.plain)
            }

            Spacer()

            Button {
                vm.prefs.surprise = true
                vm.prefs.distance = nil
                generateAndGo()
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
        }
        .padding()
        
        
        // error handling: message pop up
        .alert(item: Binding(get: { vm.error }, set: { _ in vm.error = nil })) { err in
            Alert(
                title: Text("Oops"),
                message: Text(err.localizedDescription),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
