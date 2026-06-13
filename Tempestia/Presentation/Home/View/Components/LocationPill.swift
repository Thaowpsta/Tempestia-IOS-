//
//  LocationPill.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 13/06/2026.
//

import SwiftUI

struct LocationPill: View {
    let theme: TempestiaTheme
    let locationName: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "mappin.and.ellipse")
                .foregroundColor(theme.purpleBright)
                .font(.system(size: 14, weight: .bold))
            
            Text(locationName)
                .foregroundColor(theme.text1)
                .font(.system(size: 18, weight: .semibold))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .tempestiaGlass(theme: theme, radius: 50)
    }
}

#Preview {
    LocationPill(theme: TempestiaTheme(isMorning: true), locationName: "Cairo")
}
