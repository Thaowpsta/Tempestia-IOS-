//
//  WeatherResponseDTO.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 15/06/2026.
//


struct WeatherResponseDTO: Decodable {
    let location: LocationDTO
    let current: CurrentDTO
    let forecast: ForecastDTO
}