//
//  SettingsView.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 15/06/2026.
//


import SwiftUI
import SwiftData
import Swinject

@available(iOS 17.0, *)
struct SettingsView: View {
    @Environment(\.tempestia) var theme
    
    @Query(sort: \FavoriteLocation.addedAt, order: .reverse) private var favorites: [FavoriteLocation]
    
    @AppStorage("isNotificationEnabled") private var isNotificationEnabled = false
    @AppStorage("notificationTime") private var notificationTime: Double = Date().timeIntervalSince1970
    
    private let notificationId = UUID(uuidString: "11111111-2222-3333-4444-555555555555")!
    
    var selectedTime: Binding<Date> {
        Binding(
            get: { Date(timeIntervalSince1970: notificationTime) },
            set: { newValue in notificationTime = newValue.timeIntervalSince1970 }
        )
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                AnimatedParticleBackground()
                    .ignoresSafeArea()
                
                VStack {
                    VStack(spacing: 16) {
                        
                        Toggle(isOn: $isNotificationEnabled) {
                            HStack(spacing: 12) {
                                Image(systemName: "bell.badge.fill")
                                    .foregroundColor(theme.purpleBright)
                                    .font(.system(size: 20))
                                Text("Daily Weather Summary")
                                    .font(.headline)
                                    .foregroundColor(theme.text1)
                            }
                        }
                        .tint(theme.purpleBright)
                        .onChange(of: isNotificationEnabled) { _, _ in
                            handleNotificationToggle()
                        }
                        
                        if isNotificationEnabled {
                            Divider().background(theme.glassBorder.opacity(0.3))
                            
                            DatePicker("Delivery Time", selection: selectedTime, displayedComponents: .hourAndMinute)
                                .font(.subheadline.bold())
                                .foregroundColor(theme.text1)
                                .environment(\.colorScheme, theme.isMorning ? .light : .dark)
                                .onChange(of: notificationTime) { _, _ in
                                    handleNotificationToggle()
                                }
                        }
                    }
                    .padding(20)
                    .background(theme.glassBorder.opacity(0.1))
                    .cornerRadius(24)
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                    
                    Spacer()
                }
            }
            .navigationTitle("Settings")
            .onAppear {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithTransparentBackground()
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(theme.text1)]
                appearance.titleTextAttributes = [.foregroundColor: UIColor(theme.text1)]
                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
        
    private func handleNotificationToggle() {
        if isNotificationEnabled {
            NotificationManager.shared.requestPermission()
            
            Task {
                let subtitle = await fetchCurrentWeatherSubtitle()
                
                NotificationManager.shared.scheduleAlarm(
                    id: notificationId,
                    time: Date(timeIntervalSince1970: notificationTime),
                    title: "Tempestia Daily Summary",
                    subtitle: subtitle,
                )
            }
        } else {
            NotificationManager.shared.cancelAlarm(id: notificationId)
        }
    }
    
    private func fetchCurrentWeatherSubtitle() async -> String {
        guard let repository = DependencyInjector.shared.container.resolve(WeatherRepositoryProtocol.self) else {
            return "Check the app for today's temperatures!"
        }
        
        let query: String
        if let targetCity = favorites.first {
            query = "\(targetCity.latitude),\(targetCity.longitude)"
        } else {
            query = "Alexandria"
        }
        
        do {
            let weather = try await repository.fetchWeather(query: query, days: 1)
            return "Expect \(weather.conditionText). High: \(weather.maxTemp)°C | Low: \(weather.minTemp)°C."
        } catch {
            return "Tap to see today's weather forecast."
        }
    }
}
