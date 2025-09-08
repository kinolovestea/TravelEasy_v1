//
//  MoodView.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//


import SwiftUI

// second screen to select mood
struct MoodView: View {
    @Environment(RecommendationViewModel.self) private var vm
    let onPick: (Mood) -> Void
    let onAppearReset: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text("What do you look for?")
                .font(.title2).bold()

            Grid(horizontalSpacing: 12, verticalSpacing: 12) {
                GridRow {
                    moodTile(.chill)
                    moodTile(.adventurous)
                }
                GridRow {
                    moodTile(.peaceful)
                    moodTile(.vibrant)
                }
            }

            Spacer()
        }
        .padding()
        .navigationTitle(vm.prefs.origin)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { vm.resetForEnteringMood() }
    }

    @ViewBuilder
    private func moodTile(_ mood: Mood) -> some View {
        Button {
            vm.prefs.mood = mood
            onPick(mood)
        } label: {
            VStack(spacing: 6) {
                Text(mood.emoji).font(.title3)
                Text(mood.title)
            }
            .frame(maxWidth: .infinity, minHeight: 90)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.plain)
    }

}

