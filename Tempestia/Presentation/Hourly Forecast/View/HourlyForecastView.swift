//
//  HourlyForecastView.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 14/06/2026.
//


import SwiftUI

@available(iOS 16.0, *)
struct HourlyForecastView: View {
    let hourlyData: [HourlyForecast]
    
    var body: some View {
        ZStack {

            AnimatedParticleBackground()
                .ignoresSafeArea()
            
            List {
                ForEach(hourlyData, id: \.timeEpoch) { hour in
                    HourlyRow(
                        time: Date(timeIntervalSince1970: hour.timeEpoch).toAppTime(),
                        temp: hour.temp.toAppTemp(),
                        icon: hour.conditionIcon)
                }
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
//        HourlyForecastView()
    } else {
        // Fallback on earlier versions
    }
}
