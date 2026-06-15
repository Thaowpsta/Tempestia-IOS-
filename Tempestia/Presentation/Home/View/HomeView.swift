//
//  HomeView.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 13/06/2026.
//

import SwiftUI

//
//  HomeView.swift
//  Tempestia
//

import SwiftUI

@available(iOS 16.0, *)
struct HomeView: View {
    @Environment(\.tempestia) var theme
    
    @StateObject private var viewModel = DependencyInjector.resolve(HomeViewModel.self)

    var body: some View {
        NavigationView {
            ZStack {
                AnimatedParticleBackground()
                                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        LocationPill(locationName: viewModel.weatherInfo?.locationName ?? "Locating...")
                        
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
            .onAppear {
                viewModel.fetchWeatherForCurrentLocation()
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
