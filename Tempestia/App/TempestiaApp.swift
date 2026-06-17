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

    init() {
        _ = NotificationManager.shared
    }

    var body: some Scene {
        WindowGroup {
            MainTabView().environment(
                \.tempestia,
                TempestiaTheme(isMorning: colorScheme == .dark)
            )
            .modelContainer(for: [FavoriteLocation.self, WeatherAlarm.self])
            .environmentObject(router)
        }
        .backgroundTask(.appRefresh(WeatherBackgroundTask.shared.taskId)) {
            await WeatherBackgroundTask.shared.performWeatherUpdate()
        }
    }
}
