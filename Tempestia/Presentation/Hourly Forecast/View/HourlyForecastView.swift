//
//  HourlyForecastView.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 14/06/2026.
//


import SwiftUI

struct HourlyForecastView: View {
    @Environment(\.tempestia) var theme
    
    var body: some View {
        ZStack {
            theme.bgDeep
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    HourlyRow(time: "Now", temp: "15°", icon: "sun.max.fill")
                    HourlyRow(time: "3PM", temp: "15°", icon: "cloud.sun.fill")
                    HourlyRow(time: "4PM", temp: "14°", icon: "cloud.fill")
                    HourlyRow(time: "5PM", temp: "13°", icon: "cloud.rain.fill")
                    HourlyRow(time: "6PM", temp: "12°", icon: "moon.fill")
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)
            }
        }
        .navigationTitle("Hourly Forecast")
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    HourlyForecastView()
}
