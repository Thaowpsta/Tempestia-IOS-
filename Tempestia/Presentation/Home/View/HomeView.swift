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
    @StateObject private var viewModel = DependencyInjector.resolve(HomeViewModel.self)

    var body: some View {
        NavigationView {
            ZStack {
                AnimatedParticleBackground()
                                    .ignoresSafeArea()
                ScrollView(showsIndicators: false) {
                    VStack {
                        LocationPill(locationName: viewModel.weatherInfo?.locationName ?? "Locating...")
                        
                        if viewModel.isLoading && viewModel.weatherInfo == nil {
                            ProgressView("Analyzing Atmosphere...")
                                .foregroundColor(theme.text2)
                                .padding(.top, 100)
                        } else if let errorMessage = viewModel.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                                .padding(.top, 100)
                        }
                        else if let weather = viewModel.weatherInfo {
                            
                            CurrentWeatherHeader(weather: weather)

                            SectionHeader(title: "3-DAY FORECAST", icon: "calendar")
                            DailyForecastSection(forecasts: weather.dailyForecast, hourlyData: weather.hourlyForecast)

                            SectionHeader(title: "ATMOSPHERIC DETAILS", icon: "aqi.medium")
                            AtmosphericGrid(weather: weather)
                                .padding(.bottom, 64)
                        }

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
