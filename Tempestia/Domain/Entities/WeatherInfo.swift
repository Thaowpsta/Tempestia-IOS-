//
//  WeatherInfo.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 15/06/2026.
//


struct WeatherInfo : Codable{
    var locationName: String
    let currentTemp: Double
    let conditionText: String
    let conditionIcon: String
    let maxTemp: Double
    let minTemp: Double
    let visibility: Double
    let humidity: Int
    let feelsLike: Double
    let pressure: Double
    let dailyForecast: [DailyForecast]
    let hourlyForecast: [HourlyForecast]
}
