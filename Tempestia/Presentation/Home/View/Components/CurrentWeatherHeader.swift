//
//  CurrentWeatherHeader.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 13/06/2026.
//

import SwiftUI

struct CurrentWeatherHeader: View {
    let theme: TempestiaTheme
    
    var body: some View {
        VStack() {
            Text("\(theme.isMorning ? "☀️" : "🌌")")
                .font(.system(size: 64))
            
            HStack(alignment: .top, spacing: 0) {
                Text("21")
                    .font(.system(size: 110, weight: .light))
                    .foregroundStyle(theme.tempGradient)
                
                Text("°")
                    .font(.system(size: 40, weight: .light))
                    .foregroundStyle(theme.tempGradient)
                    .offset(y: 15)
            }
            
            Text("Partly Cloudy")
                .foregroundColor(theme.text2)
                .font(.system(size: 24, weight: .medium))
            
            Text("H:16°  L:6°")
                .foregroundColor(theme.text3)
                .font(.system(size: 16, weight: .bold))
            Spacer()
        }
        .padding(.bottom, 10)
    }
}

#Preview {
    CurrentWeatherHeader(theme: TempestiaTheme(isMorning: true))
}
