//
//  LocationMode.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 18/06/2026.
//


import SwiftUI

enum LocationMode: String, CaseIterable {
    case gps = "GPS"
    case manual = "Manual (Map)"
}

enum TempUnit: String, CaseIterable {
    case celsius = "Celsius (°C)"
    case fahrenheit = "Fahrenheit (°F)"
}

enum TimeFormat: String, CaseIterable {
    case h12 = "12-Hour"
    case h24 = "24-Hour"
}

enum AppThemeMode: String, CaseIterable {
    case auto = "Auto (Time)"
    case light = "Light"
    case dark = "Dark"
}

enum AppLanguage: String, CaseIterable {
    case system = "System Default"
    case english = "English"
    case arabic = "العربية"
}

extension Double {
    func toAppTemp() -> String {
        let unitStr = UserDefaults.standard.string(forKey: "temperatureUnit") ?? TempUnit.celsius.rawValue
        
        if unitStr == TempUnit.fahrenheit.rawValue {
            let fahrenheit = (self * 9.0 / 5.0) + 32.0
            return "\(Int(fahrenheit.rounded()))°F"
        } else {
            return "\(Int(self.rounded()))°C"
        }
    }
}

extension Date {
    func toAppTime() -> String {
        let formatStr = UserDefaults.standard.string(forKey: "timeFormat") ?? TimeFormat.h12.rawValue
        let formatter = DateFormatter()
        
        if formatStr == TimeFormat.h24.rawValue {
            formatter.dateFormat = "HH:mm"
        } else {
            formatter.dateFormat = "h:mm a"
        }
        
        return formatter.string(from: self)
    }
}
