//
//  MainTabView.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 15/06/2026.
//

import SwiftUI

@available(iOS 16.0, *)
struct MainTabView: View {
    @Environment(\.tempestia) var theme
    @State private var selectedTab: AppTab = .home
    
    var body: some View {
        ZStack {
            AnimatedParticleBackground()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                switch selectedTab {
                case .home:
                    HomeView()
                case .favorites:
                    FavoritesView()
                case .alerts:
                    AlertsView()
                case .settings:
                    SettingsView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack {
                Spacer()
                CustomTabBar(selectedTab: $selectedTab)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)
            }
        }
    }
}
