//
//  AppError.swift
//  TravelEasy
//
//  Created by Yu on 9/5/25.
//


import Foundation

// Error handling: centralized error type for the app
enum AppError: LocalizedError, Identifiable {
    var id: String { localizedDescription }

    case invalidInput(String)
    case noMatch
    case dataUnavailable
    case network(String)

    var errorDescription: String? {
        switch self {
        case .invalidInput(let msg): return msg
        case .noMatch: return "No matching destination found. Choose another option!"
        case .dataUnavailable: return "Data not available."
        case .network(let msg): return msg
        }
    }
}
