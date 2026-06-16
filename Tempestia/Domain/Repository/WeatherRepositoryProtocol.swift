//
//  WeatherRepositoryProtocol.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 15/06/2026.
//


protocol WeatherRepositoryProtocol {
    func fetchWeather(query: String, days: Int) async throws -> WeatherInfo
    func searchLocations(query: String) async throws -> [LocationSearchResult]
}
