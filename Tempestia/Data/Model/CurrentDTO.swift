//
//  CurrentDTO.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 15/06/2026.
//


struct CurrentDTO: Decodable {
    let temp_c: Double
    let condition: ConditionDTO
    let vis_km: Double
    let humidity: Int
    let feelslike_c: Double
    let pressure_mb: Double
}