//
//  Weather.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/2/24.
//

import Foundation

struct Weather {
    let cityName: String
    let currentTemperature: Int
    let weatherStatus: String
    let minTemperature: Int
    let maxTemperature: Int
    let hourlyWeathers: [HourlyWeather]
    let dailyWeather: [DailyWeather]
    let coordinate: Coordinate
    let humidity: Double   // 습도
    let clouds: Double     // 구름
    let windSpeed: Double  // 바람 세기
    let pressure: Int      // 기압
}

/// 시간 별 날씨
struct HourlyWeather {
    let time: String
    let weatherStatus: String
    let temperature: Int
}

/// 일 별 날씨
struct DailyWeather {
    let day: String
    let weatherStatus: String
    let minTemperature: Int
    let maxTemperature: Int
}

extension Weather {
    static let onError = Weather(
        cityName: "찾을 수 없습니다.",
        currentTemperature: 0,
        weatherStatus: "오류",
        minTemperature: 0,
        maxTemperature: 0,
        hourlyWeathers: [],
        dailyWeather: [],
        coordinate: Coordinate(latitude: 0, longitude: 0),
        humidity: 0.0,
        clouds: 0.0,
        windSpeed: 0.0,
        pressure: 0
    )
}
