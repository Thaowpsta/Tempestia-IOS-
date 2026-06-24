//
//  LocationTracker.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 15/06/2026.
//


import Foundation
import CoreLocation

class LocationTracker: NSObject, LocationTrackerProtocol, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    
    private var locationContinuation: CheckedContinuation<(latitude: Double, longitude: Double), Error>?
    
    private let lastLatKey = "lastFetchedLatitude"
    private let lastLonKey = "lastFetchedLongitude"
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    }
    
    func getCurrentLocation() async throws -> (latitude: Double, longitude: Double) {
        if !NetworkMonitor.shared.isConnected {
            if let cachedLocation = getCachedLocation() {
                return cachedLocation
            } else {
                throw LocationError.unableToDetermineLocation
            }
        }
        
        let status = locationManager.authorizationStatus
        
        if status == .denied || status == .restricted {
            throw LocationError.unauthorized
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            if self.locationContinuation != nil {
                self.locationContinuation?.resume(throwing: LocationError.unableToDetermineLocation)
                self.locationContinuation = nil
            }
            
            self.locationContinuation = continuation
            
            if status == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
            } else {
                locationManager.requestLocation()
            }
        }
    }
    
    private func getCachedLocation() -> (latitude: Double, longitude: Double)? {
        let lat = UserDefaults.standard.double(forKey: lastLatKey)
        let lon = UserDefaults.standard.double(forKey: lastLonKey)
        
        if lat != 0.0 || lon != 0.0 {
            return (lat, lon)
        }
        return nil
    }
        
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        
        if locationContinuation != nil {
            if status == .authorizedWhenInUse || status == .authorizedAlways {

                manager.requestLocation()
            } else if status == .denied || status == .restricted {
                locationContinuation?.resume(throwing: LocationError.unauthorized)
                locationContinuation = nil
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first, let continuation = locationContinuation else { return }
        
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        
        UserDefaults.standard.set(lat, forKey: lastLatKey)
        UserDefaults.standard.set(lon, forKey: lastLonKey)
        
        continuation.resume(returning: (lat, lon))
        
        self.locationContinuation = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard let continuation = locationContinuation else { return }
        
        if let clError = error as? CLError, clError.code == .denied {
            continuation.resume(throwing: LocationError.unauthorized)
        } else if let cachedLocation = getCachedLocation() {
            continuation.resume(returning: cachedLocation)
        } else {
            continuation.resume(throwing: LocationError.unableToDetermineLocation)
        }
        
        self.locationContinuation = nil
    }
}
