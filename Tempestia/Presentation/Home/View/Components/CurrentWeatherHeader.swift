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

            HStack(alignment: .top, spacing: 0) {
                Text("\(Int(weather.currentTemp))")
                    .font(.system(size: 110, weight: .light))
                    .foregroundStyle(theme.tempGradient)

                Text("°")
                    .font(.system(size: 40, weight: .light))
                    .foregroundStyle(theme.tempGradient)
                    .offset(y: 15)
            }
            .offset(x: 10)

            Text(weather.conditionText)
                .foregroundColor(theme.text2)
                .font(.system(size: 24, weight: .medium))

            Text("H:\(Int(weather.maxTemp))°  L:\(Int(weather.minTemp))°")
                .foregroundColor(theme.text3)
                .font(.system(size: 16, weight: .bold))
        }
        .padding(.bottom, 10)
    }
}

#Preview {
//    CurrentWeatherHeader()
}
