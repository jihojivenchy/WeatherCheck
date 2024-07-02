//
//  WeatherData.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/2/24.
//

import Foundation

struct WeatherData {
    let cityName: String
    let currentTemperature: Int
    let weatherStatus: String
    let minTemperature: Int
    let maxTemperature: Int
    let hourlyWeathers: [HourlyWeather]
    let dailyWeather: [DailyWeather]
    let latitude: Double
    let longitude: Double
    let humidity: Double   // 습도
    let clouds: Double     // 구름
    let windSpeed: Double  // 바람 세기
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

extension WeatherData {
    static let onError = WeatherData(
        cityName: "찾을 수 없습니다.",
        currentTemperature: 0,
        weatherStatus: "오류",
        minTemperature: 0,
        maxTemperature: 0,
        hourlyWeathers: [],
        dailyWeather: [],
        latitude: 0.0,
        longitude: 0.0,
        humidity: 0.0,
        clouds: 0.0,
        windSpeed: 0.0
    )
}
