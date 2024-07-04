//
//  Weather.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/2/24.
//

import Foundation

struct Weather {
    let city: City
    let currentTemperature: Int
    let weatherStatus: String
    let minTemperature: Int
    let maxTemperature: Int
    let hourlyWeathers: [HourlyWeather]
    let dailyWeather: [DailyWeather]
    let humidity: Int      // 습도
    let clouds: Int        // 구름
    let windSpeed: Double  // 바람 속도
    let pressure: Int      // 기압
}

/// 시간 별 날씨
struct HourlyWeather {
    let time: String
    let iconID: String
    let temperature: Int
}

/// 일 별 날씨
struct DailyWeather {
    let dayOfWeek: String
    let iconID: String
    let minTemperature: Int
    let maxTemperature: Int
}

extension Weather {
    static let onError = Weather(
        city: City(id: 0, name: "찾을 수 없습니다", country: "KR", coordinate: Coordinate(latitude: 0, longitude: 0)),
        currentTemperature: 0,
        weatherStatus: "오류",
        minTemperature: 0,
        maxTemperature: 0,
        hourlyWeathers: [],
        dailyWeather: [],
        humidity: 0,
        clouds: 0,
        windSpeed: 0.0,
        pressure: 0
    )
}
