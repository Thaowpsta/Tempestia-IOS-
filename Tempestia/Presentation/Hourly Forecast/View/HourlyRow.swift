//
//  HourlyRow.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 14/06/2026.
//

import SwiftUI

struct HourlyRow: View {
    @Environment(\.tempestia) var theme

    let time: String
    let temp: String
    let icon: String
    
    var body: some View {
        HStack {
            Text(time)
                .foregroundColor(theme.text2)
                .font(.system(size: 18, weight: .medium))
                .frame(width: 80, alignment: .leading)
            
            Spacer()
            
            Image(systemName: icon)
                .symbolRenderingMode(.multicolor)
                .font(.system(size: 24))
            
            Spacer()
            
            Text(temp)
                .foregroundColor(theme.text1)
                .font(.system(size: 20, weight: .bold))
                .frame(alignment: .trailing)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 24)
        .tempestiaGlass(radius: 20)
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}

#Preview {
    NavigationView {
        if #available(iOS 16.0, *) {
            HourlyForecastView()
        } else {
            // Fallback on earlier versions
        }
    }
}
