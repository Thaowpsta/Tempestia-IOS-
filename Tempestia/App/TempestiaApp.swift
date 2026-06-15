//
//  TempestiaApp.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 13/06/2026.
//

import SwiftUI

@available(iOS 16.0, *)
@main
struct TempestiaApp: App {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some Scene {
        WindowGroup {
            MainTabView().environment(\.tempestia, TempestiaTheme(isMorning: colorScheme == .dark))
        }
    }
}
