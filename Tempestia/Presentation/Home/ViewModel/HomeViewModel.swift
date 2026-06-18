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
    
    func fetchWeatherForCurrentLocation() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let coords = try await locationTracker.getCurrentLocation()
            let query = "\(coords.latitude),\(coords.longitude)"
            
            self.weatherInfo = try await repository.fetchWeather(query: query, days: 3)
            self.isLoading = false
            
        } catch is CancellationError {
            print("Task cancelled by system.")
            self.isLoading = false
        } catch let error as URLError where error.code == .cancelled {
            print("Network request cancelled by system.")
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
        
        do {
            let query = "\(latitude),\(longitude)"
            self.weatherInfo = try await repository.fetchWeather(query: query, days: 3)
            self.isLoading = false
            print("Task Updated Successfully.")
            
        } catch is CancellationError {
            print("Task cancelled by system.")
            self.isLoading = false
        } catch let error as URLError where error.code == .cancelled {
            print("Network request cancelled by system.")
            self.isLoading = false 
        } catch {
            self.errorMessage = "Failed to fetch weather: \(error.localizedDescription)"
            self.isLoading = false
        }
    }
}
