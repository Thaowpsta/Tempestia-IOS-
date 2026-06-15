//
//  ForecastDayDTO.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 15/06/2026.
//

import Foundation


struct ForecastDayDTO: Decodable {
    let date_epoch: TimeInterval
    let day: DayDTO
    let hour: [HourDTO]
}
