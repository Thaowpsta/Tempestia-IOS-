//
//  HourDTO.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 15/06/2026.
//

import Foundation


struct HourDTO: Decodable {
    let time_epoch: TimeInterval
    let temp_c: Double
    let condition: ConditionDTO
}
