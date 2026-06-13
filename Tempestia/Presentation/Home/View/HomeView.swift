//
//  HomeView.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 13/06/2026.
//

import SwiftUI

struct HomeView: View {
    var isMorning: Bool = false
    private var theme: TempestiaTheme { TempestiaTheme(isMorning: isMorning) }

    var body: some View {
        NavigationView {
            ZStack {
                theme.bgDeep.edgesIgnoringSafeArea(.all)

                ScrollView {
                    VStack {
                        LocationPill(theme: theme, locationName: "Cairo")
                        
                        CurrentWeatherHeader(theme: theme)

                        SectionHeader(
                            theme: theme,
                            title: "3-DAY FORECAST",
                            icon: "calendar"
                        )
                        DailyForecastSection(theme: theme)

                        SectionHeader(
                            theme: theme,
                            title: "ATMOSPHERIC DETAILS",
                            icon: "aqi.medium"
                        )
                        AtmosphericGrid(theme: theme)
                            .padding(.bottom, 64)

                    }.padding()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
