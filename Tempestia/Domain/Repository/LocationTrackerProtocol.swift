//
//  LocationTrackerProtocol.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 15/06/2026.
//


import Foundation

protocol LocationTrackerProtocol {
    func getCurrentLocation() async throws -> (latitude: Double, longitude: Double)
}

enum LocationError: Error, LocalizedError {
    case unauthorized
    case unableToDetermineLocation
    
    var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "Location access was denied. Please enable it in Settings."
        case .unableToDetermineLocation:
            return "Could not fetch your current location."
        }
    }
}
