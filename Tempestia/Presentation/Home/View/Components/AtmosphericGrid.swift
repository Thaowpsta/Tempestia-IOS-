//
//  AtmosphericGrid.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 13/06/2026.
//

import SwiftUI

@available(iOS 16.0, *)
struct AtmosphericGrid: View {
    @Environment(\.tempestia) var theme
    let weather: WeatherInfo 

    let columns = [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            AtmosphericCard(title: "Visibility", value: "\(Int(weather.visibility)) km", icon: "👁️")
            AtmosphericCard(title: "Humidity", value: "\(weather.humidity)%", icon: "💧")
            AtmosphericCard(title: "Feels Like", value: "\(Int(weather.feelsLike))°", icon: "🌡️")
            AtmosphericCard(title: "Pressure", value: "\(Int(weather.pressure)) mb", icon: "⏱️")
        }
    }
}

#Preview {
    if #available(iOS 16.0, *) {
//        AtmosphericGrid()
    } else {
        // Fallback on earlier versions
    }
}
