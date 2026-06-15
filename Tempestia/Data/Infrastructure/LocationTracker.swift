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
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    }
    
    func getCurrentLocation() async throws -> (latitude: Double, longitude: Double) {
        let status = locationManager.authorizationStatus
        
        if status == .denied || status == .restricted {
            throw LocationError.unauthorized
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            self.locationContinuation = continuation
            
            if status == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
            }
            
            locationManager.requestLocation()
        }
    }
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first, let continuation = locationContinuation else { return }
        
        continuation.resume(returning: (location.coordinate.latitude, location.coordinate.longitude))
        
        self.locationContinuation = nil 
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard let continuation = locationContinuation else { return }
        
        if let clError = error as? CLError, clError.code == .denied {
            continuation.resume(throwing: LocationError.unauthorized)
        } else {
            continuation.resume(throwing: LocationError.unableToDetermineLocation)
        }
        
        self.locationContinuation = nil
    }
}
