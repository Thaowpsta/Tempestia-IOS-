//
//  WeatherAlarm.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 16/06/2026.
//


import Foundation
import SwiftData

@available(iOS 17.0, *)
@Model
class WeatherAlarm {
    @Attribute(.unique) var id: UUID
    var time: Date
    var title: String
    var isAlarm: Bool
    var isEnabled: Bool
    var addedAt: Date
    
    init(time: Date, title: String, isAlarm: Bool = false, isEnabled: Bool = true) {
        self.id = UUID()
        self.time = time
        self.title = title
        self.isAlarm = isAlarm
        self.isEnabled = isEnabled
        self.addedAt = Date()
    }
}
