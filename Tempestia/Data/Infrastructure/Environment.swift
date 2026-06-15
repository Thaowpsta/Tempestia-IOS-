//
//  Environment.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 15/06/2026.
//


import Foundation

public enum Env {
    enum Keys {
        static let weatherApiKey = "WeatherAPIKey"
    }
    
    static let apiKey: String = {
        guard let apiKeyProperty = Bundle.main.object(forInfoDictionaryKey: Keys.weatherApiKey) as? String else {
            fatalError("WeatherAPIKey not found in Info.plist")
        }
        
        return apiKeyProperty.trimmingCharacters(in: .whitespacesAndNewlines)
    }()
}
