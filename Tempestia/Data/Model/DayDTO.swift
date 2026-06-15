//
//  DayDTO.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 15/06/2026.
//


struct DayDTO: Decodable {
    let maxtemp_c: Double
    let mintemp_c: Double
    let condition: ConditionDTO
}