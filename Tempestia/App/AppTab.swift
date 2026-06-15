//
//  AppTab.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 15/06/2026.
//


import SwiftUI

@available(iOS 16.0, *)
enum AppTab: String, CaseIterable {
    case home = "house.fill"
    case favorites = "heart.fill"
    case alerts = "bell.fill"
    case settings = "gearshape.fill"
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .favorites: return "Favorites"
        case .alerts: return "Alerts"
        case .settings: return "Settings"
        }
    }
}