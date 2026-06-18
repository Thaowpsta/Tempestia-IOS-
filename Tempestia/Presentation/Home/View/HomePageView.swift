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
    
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @State private var showingOfflineAlert = false
    
    let favorite: FavoriteLocation?

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                LocationPill(locationName: viewModel.weatherInfo?.locationName ?? (favorite?.name ?? "Locating..."))
                    .padding(.top, 24)
                
                if viewModel.isLoading && viewModel.weatherInfo == nil {
                    ProgressView(LocalizedStringKey("Analyzing Atmosphere..."))
                        .foregroundColor(theme.text2)
                        .padding(.top, 100)
                } else if let errorMessage = viewModel.errorMessage, !errorMessage.isEmpty {
                    Text(LocalizedStringKey(errorMessage))
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
        .alert(LocalizedStringKey("Offline"), isPresented: $showingOfflineAlert) {
            Button(LocalizedStringKey("OK"), role: .cancel) { }
        } message: {
            Text(LocalizedStringKey("You are offline. Showing your previously saved weather data."))
        }
        .refreshable {
            if networkMonitor.isConnected {
                await fetchWeatherData()
            } else {
                showingOfflineAlert = true
            }
        }
        .onAppear {
            if viewModel.weatherInfo == nil {
                Task {
                    await fetchWeatherData()
                    if !networkMonitor.isConnected && viewModel.weatherInfo != nil {
                        showingOfflineAlert = true
                    }
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
