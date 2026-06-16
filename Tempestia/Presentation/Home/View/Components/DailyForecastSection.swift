//
//  SectionHeader 2.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 13/06/2026.
//

import SwiftUI

@available(iOS 16.0, *)
struct DailyForecastSection: View {
    @Environment(\.tempestia) var theme
    let forecasts: [DailyForecast]
    let hourlyData: [HourlyForecast] 

    var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(forecasts.enumerated()), id: \.element.dateEpoch) { index, day in
                DailyForecastRow(
                    day: index == 0 ? "Today" : day.date,
                    icon: day.conditionIcon,
                    minTemp: "\(Int(day.minTemp))°",
                    maxTemp: "\(Int(day.maxTemp))°",
                    hourlyData: hourlyData
                )

                if index < forecasts.count - 1 {
                    Divider().background(theme.glassBorder.opacity(0.3)).padding(.vertical, 8)
                }
            }
        }
        .padding(24)
        .tempestiaGlass(radius: 32)
    }
}


@available(iOS 16.0, *)
extension View {
    func letterSpacing(_ spacing: CGFloat) -> some View {
        self.tracking(spacing)
    }
}

#Preview {
    if #available(iOS 16.0, *) {
//        DailyForecastSection()
    } else {
        // Fallback on earlier versions
    }
}
