//
//  TempestiaApp.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 13/06/2026.
//

import SwiftData
import SwiftUI

@available(iOS 17.0, *)
@main
struct TempestiaApp: App {
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject private var router = AppRouter()
    @StateObject private var networkMonitor = NetworkMonitor.shared
    
    @AppStorage("appTheme") private var appTheme: AppThemeMode = .auto
    @AppStorage("appLanguage") private var appLanguage: AppLanguage = .system
    @AppStorage("temperatureUnit") private var temperatureUnit: TempUnit = .celsius
    @AppStorage("timeFormat") private var timeFormat: TimeFormat = .h12

    init() {
        _ = NotificationManager.shared
    }

    var timeBasedIsMorning: Bool {
        let hour = Calendar.current.component(.hour, from: Date())
        return hour >= 5 && hour < 18
    }
    
    var activeColorScheme: ColorScheme? {
        switch appTheme {
        case .light: return .light
        case .dark: return .dark
        case .auto: return timeBasedIsMorning ? .light : .dark
        }
    }
    
    var isMorningTheme: Bool {
        switch appTheme {
        case .light: return true
        case .dark: return false
        case .auto: return timeBasedIsMorning
        }
    }
    
    var activeLocale: Locale {
        switch appLanguage {
        case .english: return Locale(identifier: "en")
        case .arabic: return Locale(identifier: "ar")
        case .system: return Locale.current
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView().environment(
                \.tempestia,
                TempestiaTheme(isMorning: isMorningTheme)
            )
            .modelContainer(for: [FavoriteLocation.self, WeatherAlarm.self])
            .environmentObject(router)
            .preferredColorScheme(activeColorScheme)
            .environment(\.locale, activeLocale)
            .environment(\.layoutDirection, appLanguage == .arabic ? .rightToLeft : .leftToRight)
            .environmentObject(networkMonitor)
            .id("\(appLanguage.rawValue)\(temperatureUnit.rawValue)\(timeFormat.rawValue)\(appTheme.rawValue)\(colorScheme)")
        }
        .backgroundTask(.appRefresh(WeatherBackgroundTask.shared.taskId)) {
            await WeatherBackgroundTask.shared.performWeatherUpdate()
        }
    }
}
