//
//  SectionHeader.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 13/06/2026.
//

import SwiftUI

struct SectionHeader: View {
    let theme: TempestiaTheme
    let title: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundColor(theme.text3)
                .font(.system(size: 14, weight: .bold))
            
            Text(title)
                .foregroundColor(theme.text3)
                .font(.system(size: 12, weight: .bold))
            Spacer()
        }
    }
}

#Preview {
    SectionHeader(theme: TempestiaTheme(isMorning: true), title: "Header", icon: "tempestia_dark")
}
