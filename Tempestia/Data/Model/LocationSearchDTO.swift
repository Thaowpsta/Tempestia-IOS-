//
//  LocationSearchDTO.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 16/06/2026.
//


import Foundation

struct LocationSearchDTO: Decodable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    
    func toDomain() -> LocationSearchResult {
        return LocationSearchResult(
            id: id,
            name: name,
            region: region,
            country: country,
            latitude: lat,
            longitude: lon
        )
    }
}
