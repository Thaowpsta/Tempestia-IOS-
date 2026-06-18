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
    
    private func cacheKey(for query: String) -> String {
        return "cached_weather_\(query)"
    }
    
    private func saveToCache(_ weather: WeatherInfo, query: String) {
        if let data = try? JSONEncoder().encode(weather) {
            UserDefaults.standard.set(data, forKey: cacheKey(for: query))
        }
    }
    
    private func loadFromCache(query: String) -> WeatherInfo? {
        if let data = UserDefaults.standard.data(forKey: cacheKey(for: query)),
           let weather = try? JSONDecoder().decode(WeatherInfo.self, from: data) {
            return weather
        }
        return nil
    }
    
    func fetchWeatherForCurrentLocation() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let coords = try await locationTracker.getCurrentLocation()
            let query = "\(coords.latitude),\(coords.longitude)"
            
            guard NetworkMonitor.shared.isConnected else {
                if let cached = loadFromCache(query: "current_location") {
                    self.weatherInfo = cached
                    self.errorMessage = ""
                } else {
                    self.errorMessage = "No internet connection. Please try again later."
                }
                self.isLoading = false
                return
            }
            
            self.weatherInfo = try await repository.fetchWeather(query: query, days: 3)
            if let weather = self.weatherInfo { saveToCache(weather, query: "current_location") }
            self.isLoading = false
            
        } catch is CancellationError {
            self.isLoading = false
        } catch let error as URLError where error.code == .cancelled {
            self.isLoading = false
        } catch let error as LocationError {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
        } catch {
            self.errorMessage = "Failed to fetch weather: \(error.localizedDescription)"
            self.isLoading = false
        }
    }
    
    func fetchWeatherForCoordinates(latitude: Double, longitude: Double) async {
        isLoading = true
        errorMessage = nil
        let query = "\(latitude),\(longitude)"
        
        guard NetworkMonitor.shared.isConnected else {
            if let cached = loadFromCache(query: query) {
                self.weatherInfo = cached
                self.errorMessage = ""
            } else {
                self.errorMessage = "No internet connection. Please try again later."
            }
            self.isLoading = false
            return
        }
        
        do {
            self.weatherInfo = try await repository.fetchWeather(query: query, days: 3)
            if let weather = self.weatherInfo { saveToCache(weather, query: query) }
            self.isLoading = false
            
        } catch is CancellationError {
            self.isLoading = false
        } catch let error as URLError where error.code == .cancelled {
            self.isLoading = false
        } catch {
            self.errorMessage = "Failed to fetch weather: \(error.localizedDescription)"
            self.isLoading = false
        }
    }
}
