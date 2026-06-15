//
//  WeatherRepository.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 15/06/2026.
//


import Foundation

class WeatherRepository: WeatherRepositoryProtocol {
    
    private let apiKey = Env.apiKey
    private let baseURL = "https://api.weatherapi.com/v1"
    
    func fetchWeather(query: String, days: Int = 3) async throws -> WeatherInfo {
        let urlString = "\(baseURL)/forecast.json?key=\(apiKey)&q=\(query)&days=\(days)&aqi=yes&alerts=no"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        let dto = try JSONDecoder().decode(WeatherResponseDTO.self, from: data)
        
        return WeatherMapper.map(dto: dto)
    }
}
