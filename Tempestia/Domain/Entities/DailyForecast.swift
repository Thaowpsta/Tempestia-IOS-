//
//  DailyForecast.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 15/06/2026.
//

import Foundation


struct DailyForecast: Codable {
    let date: String 
    let dateEpoch: TimeInterval
    let maxTemp: Double
    let minTemp: Double
    let conditionIcon: String
}
