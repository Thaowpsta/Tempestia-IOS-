//
//  MainTabView.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 15/06/2026.
//

import SwiftUI

@available(iOS 17.0, *)
struct MainTabView: View {
    @Environment(\.tempestia) var theme
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        ZStack {
            AnimatedParticleBackground()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                switch router.activeTab {
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
                CustomTabBar(selectedTab: $router.activeTab)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)
            }
        }
    }
}
