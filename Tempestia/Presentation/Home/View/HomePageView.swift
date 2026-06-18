//
//  HomePageView.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 16/06/2026.
//


import SwiftUI

@available(iOS 17.0, *)
struct HomePageView: View {
    @Environment(\.tempestia) var theme
    
    @StateObject private var viewModel = DependencyInjector.resolve(HomeViewModel.self)
    
    let favorite: FavoriteLocation?

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                LocationPill(locationName: viewModel.weatherInfo?.locationName ?? (favorite?.name ?? "Locating..."))
                    .padding(.top, 24)
                
                if viewModel.isLoading && viewModel.weatherInfo == nil {
                    ProgressView("Analyzing Atmosphere...")
                        .foregroundColor(theme.text2)
                        .padding(.top, 100)
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.top, 100)
                } else if let weather = viewModel.weatherInfo {
                    CurrentWeatherHeader(weather: weather)

                    SectionHeader(title: "3-DAY FORECAST", icon: "calendar")
                    DailyForecastSection(forecasts: weather.dailyForecast, hourlyData: weather.hourlyForecast)

                    SectionHeader(title: "ATMOSPHERIC DETAILS", icon: "aqi.medium")
                    AtmosphericGrid(weather: weather)
                        .padding(.bottom, 64)
                }
            }
            .padding()
        }
        .refreshable {
            await fetchWeatherData()
        }
        .onAppear {
            if viewModel.weatherInfo == nil {
                Task {
                    await fetchWeatherData()
                }
            }
        }
    }
    
    private func fetchWeatherData() async {
        if let fav = favorite {
            await viewModel.fetchWeatherForCoordinates(latitude: fav.latitude, longitude: fav.longitude)
        } else {
            await viewModel.fetchWeatherForCurrentLocation()
        }
    }
}
