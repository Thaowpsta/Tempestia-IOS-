//
//  DailyForecastRow.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 13/06/2026.
//

import SwiftUI

struct DailyForecastRow: View {
    @Environment(\.tempestia) var theme

    let day: String
    let icon: String
    let minTemp: String
    let maxTemp: String
    
    var body: some View {
        NavigationLink(destination: HourlyForecastView()) {
            HStack {
                Text(day)
                    .foregroundColor(theme.text2)
                    .font(.system(size: 16, weight: .medium))
                    .frame(width: 60, alignment: .leading)
                
                Spacer()
                
                Text(icon)
                    .font(.system(size: 20))
                
                Spacer()
                
                Text("\(maxTemp) / \(minTemp)")
                    .foregroundColor(theme.text1)
                    .font(.system(size: 16, weight: .semibold))
                    .frame(width: 100, alignment: .trailing)
            }
        }
    }
}

#Preview {
    DailyForecastRow( day: "Sunday", icon: "tempestia_dark", minTemp: "18", maxTemp: "30")
}
