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
            AtmosphericCard(title: "VISIBILITY", value: "\(Int(weather.visibility)) km", subtext: "Clear view", icon: "👁️")
            AtmosphericCard(title: "HUMIDITY", value: "\(weather.humidity)%", subtext: "Comfortable", icon: "💧")
            AtmosphericCard(title: "FEELS LIKE", value: "\(Int(weather.feelsLike))°", subtext: "Similar to actual", icon: "🌡️")
            AtmosphericCard(title: "PRESSURE", value: "\(Int(weather.pressure)) mb", subtext: "Normal pressure", icon: "⏱️")
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
