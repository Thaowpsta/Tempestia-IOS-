//
//  TempestiaApp.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 13/06/2026.
//

import SwiftUI
import SwiftData

@available(iOS 17.0, *)
@main
struct TempestiaApp: App {
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject private var router = AppRouter()
    
    var body: some Scene {
        WindowGroup {
            MainTabView().environment(\.tempestia, TempestiaTheme(isMorning: colorScheme == .dark))
                .modelContainer(for: FavoriteLocation.self)
                .environmentObject(router)
        }
    }
}
