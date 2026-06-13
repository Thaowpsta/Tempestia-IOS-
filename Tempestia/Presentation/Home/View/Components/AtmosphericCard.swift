//
//  AtmosphericCard.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 13/06/2026.
//

import SwiftUI

struct AtmosphericCard: View {
    let theme: TempestiaTheme
    let title: String
    let value: String
    let subtext: String
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(icon)
                .font(.system(size: 28))
                .padding(.bottom, 4)
            
            Text(title)
                .foregroundColor(theme.text3)
                .font(.system(size: 11, weight: .semibold))
//                .letterSpacing(1.0)
            
            Text(value)
                .foregroundColor(theme.text1)
                .font(.system(size: 24, weight: .bold))
            
            Text(subtext)
                .foregroundColor(theme.text3)
                .font(.system(size: 12, weight: .medium))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .tempestiaGlass(theme: theme, radius: 24)
    }
}

#Preview {
    AtmosphericCard(theme: TempestiaTheme(isMorning: true), title: "Title", value: "value", subtext: "SubText", icon: "tempestia_dark")
}
