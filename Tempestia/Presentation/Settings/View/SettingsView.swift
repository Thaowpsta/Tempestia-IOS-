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
    
    @AppStorage("locationMode") private var locationMode: LocationMode = .gps
    @AppStorage("temperatureUnit") private var temperatureUnit: TempUnit = .celsius
    @AppStorage("timeFormat") private var timeFormat: TimeFormat = .h12
    @AppStorage("appTheme") private var appTheme: AppThemeMode = .auto
    @AppStorage("appLanguage") private var appLanguage: AppLanguage = .system
    
    @State private var showingMapPicker = false
    
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
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 24) {
                        
                        settingsSection {
                            Toggle(isOn: $isNotificationEnabled) {
                                settingsRowLabel(icon: "bell.badge.fill", title: "Daily Weather Summary")
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
                        
                        settingsSection {
                            settingsPickerRow(icon: "location.fill", title: "Location Mode", selection: $locationMode)
                            
                            if locationMode == .manual {
                                Divider().background(theme.glassBorder.opacity(0.3))
                                Button(action: { showingMapPicker = true }) {
                                    HStack {
                                        Text("Pick location on Map...")
                                            .font(.subheadline.bold())
                                            .foregroundColor(theme.purpleBright)
                                        Spacer()
                                        Image(systemName: "map.fill")
                                            .foregroundColor(theme.purpleBright)
                                    }
                                    .padding(.vertical, 4)
                                }
                            }
                        }
                        
                        settingsSection {
                            settingsPickerRow(icon: "thermometer", title: "Temperature Unit", selection: $temperatureUnit)
                            Divider().background(theme.glassBorder.opacity(0.3))
                            settingsPickerRow(icon: "clock.fill", title: "Time Format", selection: $timeFormat)
                        }
                        
                        settingsSection {
                            settingsPickerRow(icon: "paintpalette.fill", title: "App Theme", selection: $appTheme)
                            Divider().background(theme.glassBorder.opacity(0.3))
                            settingsPickerRow(icon: "globe", title: "Language", selection: $appLanguage)
                        }
                        
                        Spacer().frame(height: 100)
                    }
                    .padding(.top, 24)
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
            .sheet(isPresented: $showingMapPicker) {
                ZStack {
                    theme.bgDeep.ignoresSafeArea()
                    Text("Map Picker Coming Soon!")
                        .foregroundColor(theme.text1)
                }
                .presentationDetents([.large])
            }
        }
    }
        
    private func settingsSection<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(spacing: 16) {
            content()
        }
        .padding(20)
        .background(theme.glassBorder.opacity(0.1))
        .cornerRadius(24)
        .padding(.horizontal, 24)
    }
    
    private func settingsRowLabel(icon: String, title: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(theme.purpleBright)
                .font(.system(size: 20))
                .frame(width: 24)
            
            Text(LocalizedStringKey(title))
                .font(.headline)
                .foregroundColor(theme.text1)
        }
    }
    
    private func settingsPickerRow<T: Hashable & RawRepresentable>(icon: String, title: String, selection: Binding<T>) -> some View where T.RawValue == String, T: CaseIterable {
        HStack {
            settingsRowLabel(icon: icon, title: title)
            Spacer()
            Picker("", selection: selection) {
                ForEach(Array(T.allCases as! [T]), id: \.self) { item in
                    Text(LocalizedStringKey(item.rawValue)).tag(item)
                }
            }
            .pickerStyle(.menu)
            .tint(theme.text3)
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
                    title: "Tempestia",
                    subtitle: subtitle,
                )
            }
        } else {
            NotificationManager.shared.cancelAlarm(id: notificationId)
        }
    }
    
    private func fetchCurrentWeatherSubtitle() async -> String {
        guard let repository = DependencyInjector.shared.container.resolve(WeatherRepositoryProtocol.self),
              let locationTracker = DependencyInjector.shared.container.resolve(LocationTrackerProtocol.self) else {
            return "Check the app for today's temperatures!"
        }
        
        var query: String = "Alexandria"
        
        do {
            let location = try await locationTracker.getCurrentLocation()
            query = "\(location.latitude),\(location.longitude)"
        } catch {
            if let targetCity = favorites.first {
                query = "\(targetCity.latitude),\(targetCity.longitude)"
            }
        }
        
        do {
            let weather = try await repository.fetchWeather(query: query, days: 1)
            return "Expect \(weather.conditionText) today. High: \(weather.maxTemp.toAppTemp()) | Low: \(weather.minTemp.toAppTemp())."
        } catch {
            return "Tap to see today's weather forecast."
        }
    }
}
