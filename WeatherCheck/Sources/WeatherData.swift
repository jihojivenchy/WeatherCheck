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
