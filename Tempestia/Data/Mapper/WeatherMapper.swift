//
//  WeatherMapper.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 15/06/2026.
//


import Foundation

struct WeatherMapper {
    static func map(dto: WeatherResponseDTO) -> WeatherInfo {
        let today = dto.forecast.forecastday.first
        
        let daily = dto.forecast.forecastday.map { dayDTO in
            DailyForecast(
                date: formatDay(epoch: dayDTO.date_epoch),
                dateEpoch: dayDTO.date_epoch,
                maxTemp: dayDTO.day.maxtemp_c,
                minTemp: dayDTO.day.mintemp_c,
                conditionIcon: getEmoji(for: dayDTO.day.condition.code)
            )
        }
        
        let hourly = today?.hour.map { hourDTO in
            HourlyForecast(
                time: formatHour(epoch: hourDTO.time_epoch),
                timeEpoch: hourDTO.time_epoch,
                temp: hourDTO.temp_c,
                conditionIcon: getEmoji(for: hourDTO.condition.code)
            )
        } ?? []
        
        return WeatherInfo(
            locationName: dto.location.name,
            currentTemp: dto.current.temp_c,
            conditionText: dto.current.condition.text,
            conditionIcon: getEmoji(for: dto.current.condition.code),
            maxTemp: today?.day.maxtemp_c ?? 0.0,
            minTemp: today?.day.mintemp_c ?? 0.0,
            visibility: dto.current.vis_km,
            humidity: dto.current.humidity,
            feelsLike: dto.current.feelslike_c,
            pressure: dto.current.pressure_mb,
            dailyForecast: daily,
            hourlyForecast: hourly
        )
    }
    
    private static func getEmoji(for code: Int) -> String {
        switch code {
        case 1000: return "☀️"
        case 1003: return "⛅"
        case 1063...1201: return "🌧"
        default: return "☁️"
        }
    }
    
    private static func formatDay(epoch: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: epoch)
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }
    
    private static func formatHour(epoch: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: epoch)
        let formatter = DateFormatter()
        formatter.dateFormat = "ha"
        return formatter.string(from: date)
    }
}
