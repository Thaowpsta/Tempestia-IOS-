//
//  ForecastDTO.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 15/06/2026.
//


struct ForecastDTO: Decodable {
    let forecastday: [ForecastDayDTO]
}