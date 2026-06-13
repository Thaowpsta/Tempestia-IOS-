//
//  AtmosphericGrid.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 13/06/2026.
//

import SwiftUI

struct AtmosphericGrid: View {
    let theme: TempestiaTheme
    let columns = [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            AtmosphericCard(theme: theme, title: "VISIBILITY", value: "10 km", subtext: "Perfect clear view", icon: "👁️")
            AtmosphericCard(theme: theme, title: "HUMIDITY", value: "36%", subtext: "Comfortable", icon: "💧")
            AtmosphericCard(theme: theme, title: "FEELS LIKE", value: "16°", subtext: "Slightly cooler", icon: "🌡️")
            AtmosphericCard(theme: theme, title: "PRESSURE", value: "1021 hPa", subtext: "Normal pressure", icon: "⏱️")
        }
    }
}

#Preview {
    AtmosphericGrid(theme: TempestiaTheme(isMorning: true))
}
