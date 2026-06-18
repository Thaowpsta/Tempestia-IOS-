//
//  HomeView.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 13/06/2026.
//

import SwiftUI
import SwiftData

@available(iOS 17.0, *)
struct HomeView: View {
    @Environment(\.tempestia) var theme
    @EnvironmentObject var router: AppRouter
    
    @Query(sort: \FavoriteLocation.addedAt, order: .forward) private var favorites: [FavoriteLocation]

    private var pageIds: [String] {
        ["current"] + favorites.map { $0.id.uuidString }
    }

    var body: some View {
        NavigationView {

            ZStack(alignment: .top) {

                AnimatedParticleBackground().ignoresSafeArea()
                
                TabView(selection: $router.activeHomePageId) {
                    
                    HomePageView(favorite: nil)
                        .tag("current")
                    
                    ForEach(favorites) { favorite in
                        HomePageView(favorite: favorite)
                            .tag(favorite.id.uuidString)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .padding(.bottom, 60)
                
                HStack(spacing: 8) {
                    ForEach(pageIds, id: \.self) { id in
                        Circle()
                            .fill(router.activeHomePageId == id ? theme.purpleBright : theme.text3.opacity(0.4))
                            .frame(
                                width: router.activeHomePageId == id ? 10 : 6,
                                height: router.activeHomePageId == id ? 10 : 6
                            )
                            .animation(.spring(), value: router.activeHomePageId)
                    }
                }
                .padding(.top, 10) 
            }
        }
    }
}

#Preview {
    if #available(iOS 17.0, *) {
        HomeView()
    } else {
        // Fallback on earlier versions
    }
}
