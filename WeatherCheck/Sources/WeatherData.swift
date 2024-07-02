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
}

struct HourlyWeather {
    let time: String
    let weatherStatus: String
    let temperature: Int
}


extension WeatherData {
    static let onError = WeatherData(
        cityName: "찾을 수 없습니다.",
        currentTemperature: 0,
        weatherStatus: "오류",
        minTemperature: 0,
        maxTemperature: 0,
        hourlyWeathers: []
    )
}
