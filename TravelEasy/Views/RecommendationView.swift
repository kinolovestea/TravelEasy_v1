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
    let tryAnother: () -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            if let d = vm.recommended {
                Text("Your perfect destination").font(.title2).bold()

                VStack(alignment: .leading, spacing: 8) {
                    Text("\(d.name), \(d.country)")
                        .font(.title3).bold()
                    
                    Text(hoursLine(for: d))
                        .foregroundStyle(.secondary)

                    Text("Perfect for \(vm.prefs.mood?.title ?? "you")\(vm.prefs.mood?.emoji ?? "")")
                        .padding(.top, 6)
                    
                    Text("Famous for \(d.activities.joined(separator: ", "))")
                        .foregroundStyle(.secondary)
                }
                .padding()
                .background(Color.pink.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 12))

                // weather not shown right now, will add weather api in future dev
                
                
                Button("Try Another 🔄") {
                    tryAnother()
                }
                .buttonStyle(.bordered)
                .padding(.top, 8)

                Spacer()
            } else {
                Button("Try Another 🔄") {
                    tryAnother()
                }
                .buttonStyle(.bordered)
                Spacer()
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar { ToolbarItem(placement: .navigationBarLeading) { EmptyView() } }
        .gesture(DragGesture())
    }

    private func hoursLine(for d: Destination) -> String {
        switch d.typicalBand {
        case .h1_2: return "Approx. 1–2 hour flight"
        case .h3_5: return "Approx. 3–5 hour flight"
        case .h5_plus: return "5+ hour flight"
        }
    }
}
