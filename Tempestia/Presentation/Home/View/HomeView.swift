//
//  HomeView.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 13/06/2026.
//

import SwiftUI

@available(iOS 16.0, *)
struct HomeView: View {
    @Environment(\.tempestia) var theme

    var body: some View {
        NavigationView {
            ZStack {
                AnimatedParticleBackground()
                                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        LocationPill(locationName: "Cairo")
                        
                        CurrentWeatherHeader()

                        SectionHeader(
                            title: "3-DAY FORECAST",
                            icon: "calendar"
                        )
                        DailyForecastSection()

                        SectionHeader(
                            title: "ATMOSPHERIC DETAILS",
                            icon: "aqi.medium"
                        )
                        AtmosphericGrid()
                            .padding(.bottom, 64)

                    }.padding()
                }
            }
        }
    }
}

#Preview {
    if #available(iOS 16.0, *) {
        HomeView()
    } else {
        // Fallback on earlier versions
    }
}
