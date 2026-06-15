//
//  SectionHeader 2.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 13/06/2026.
//

import SwiftUI

struct DailyForecastSection: View {
    @Environment(\.tempestia) var theme
    
    var body: some View {
        VStack(spacing: 0) {
            DailyForecastRow(day: "Today", icon: "⛅", minTemp: "7.8°", maxTemp: "15.5°")
            Divider().background(theme.glassBorder.opacity(0.3)).padding(.vertical, 8)
            DailyForecastRow(day: "Wed", icon: "🌧", minTemp: "6.4°", maxTemp: "16.1°")
            Divider().background(theme.glassBorder.opacity(0.3)).padding(.vertical, 8)
            DailyForecastRow(day: "Thu", icon: "☀", minTemp: "8.7°", maxTemp: "17.8°")
        }
        .padding(24)
        .tempestiaGlass()
    }
}


@available(iOS 16.0, *)
extension View {
    func letterSpacing(_ spacing: CGFloat) -> some View {
        self.tracking(spacing)
    }
}

#Preview {
    DailyForecastSection()
}
