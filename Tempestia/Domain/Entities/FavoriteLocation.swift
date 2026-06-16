//
//  FavoriteLocation.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 16/06/2026.
//


import Foundation
import SwiftData

@available(iOS 17.0, *)
@Model
class FavoriteLocation {
    @Attribute(.unique) var id: UUID
    var name: String
    var latitude: Double
    var longitude: Double
    var addedAt: Date
    
    init(name: String, latitude: Double, longitude: Double) {
        self.id = UUID()
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.addedAt = Date()
    }
}
