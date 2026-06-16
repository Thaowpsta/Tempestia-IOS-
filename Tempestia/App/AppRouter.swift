//
//  AppRouter.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 16/06/2026.
//


import SwiftUI
import Combine

@available(iOS 16.0, *)
class AppRouter: ObservableObject {
    @Published var activeTab: AppTab = .home
    @Published var activeHomePageId: String = "current"
    
    func navigateToFavorite(id: UUID) {
        activeHomePageId = id.uuidString
        activeTab = .home
    }
}
