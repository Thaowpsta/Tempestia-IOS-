//
//  CurrentWeatherHeader.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 13/06/2026.
//

import SwiftUI

struct CurrentWeatherHeader: View {
    @Environment(\.tempestia) var theme
    let weather: WeatherInfo

    var body: some View {
        VStack(spacing: 14) {
            Text(weather.conditionIcon)
                .font(.system(size: 64))

            Text(weather.currentTemp.toAppTemp())
                .font(.system(size: 110, weight: .light))
                .foregroundStyle(theme.tempGradient)

            Text(LocalizedStringKey(weather.conditionText))
                .foregroundColor(theme.text2)
                .font(.system(size: 24, weight: .medium))

            Text(
                "H:\(weather.maxTemp.toAppTemp())  L:\(weather.minTemp.toAppTemp())"
            )
            .foregroundColor(theme.text3)
            .font(.system(size: 16, weight: .bold))
        }
        .padding(.bottom, 10)
    }
}
