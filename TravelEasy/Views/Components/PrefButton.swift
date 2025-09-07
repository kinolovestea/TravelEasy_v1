//
//  Components.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//

import SwiftUI

// build button component
struct PrefButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(title, action: action)
            .frame(maxWidth: .infinity)
            .padding(12)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
    }
}

