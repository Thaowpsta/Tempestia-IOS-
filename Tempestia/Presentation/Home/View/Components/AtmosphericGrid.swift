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

    let columns = [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            AtmosphericCard(title: "VISIBILITY", value: "10 km", subtext: "Perfect clear view", icon: "👁️")
            AtmosphericCard(title: "HUMIDITY", value: "36%", subtext: "Comfortable", icon: "💧")
            AtmosphericCard(title: "FEELS LIKE", value: "16°", subtext: "Slightly cooler", icon: "🌡️")
            AtmosphericCard(title: "PRESSURE", value: "1021 hPa", subtext: "Normal pressure", icon: "⏱️")
        }
    }
}

#Preview {
    if #available(iOS 16.0, *) {
        AtmosphericGrid()
    } else {
        // Fallback on earlier versions
    }
}
