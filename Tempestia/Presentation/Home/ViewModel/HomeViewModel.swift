//
//  HomeViewModel.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 15/06/2026.
//

import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var weatherInfo: WeatherInfo?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let repository: WeatherRepositoryProtocol
    private let locationTracker: LocationTrackerProtocol
    
    init(repository: WeatherRepositoryProtocol, locationTracker: LocationTrackerProtocol) {
        self.repository = repository
        self.locationTracker = locationTracker
    }
    
    func fetchWeatherForCurrentLocation() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let coords = try await locationTracker.getCurrentLocation()
                
                let query = "\(coords.latitude),\(coords.longitude)"
                
                self.weatherInfo = try await repository.fetchWeather(query: query, days: 3)
                self.isLoading = false
                
            } catch let error as LocationError {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            } catch {
                self.errorMessage = "Failed to fetch weather: \(error.localizedDescription)"
                self.isLoading = false
            }
        }
    }
}
