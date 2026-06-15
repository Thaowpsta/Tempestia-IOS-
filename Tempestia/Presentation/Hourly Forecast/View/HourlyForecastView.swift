//
//  HourlyForecastView.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 14/06/2026.
//


import SwiftUI

@available(iOS 16.0, *)
struct HourlyForecastView: View {
    var body: some View {
        ZStack {

            AnimatedParticleBackground()
                .ignoresSafeArea()
            
            List {
                HourlyRow(time: "Now", temp: "15°", icon: "sun.max.fill")
                HourlyRow(time: "3PM", temp: "15°", icon: "cloud.sun.fill")
                HourlyRow(time: "4PM", temp: "14°", icon: "cloud.fill")
                HourlyRow(time: "5PM", temp: "13°", icon: "cloud.rain.fill")
                HourlyRow(time: "6PM", temp: "12°", icon: "moon.fill")
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .padding(.horizontal, 24)
        }
        .navigationTitle("Hourly Forecast")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    if #available(iOS 16.0, *) {
        HourlyForecastView()
    } else {
        // Fallback on earlier versions
    }
}
