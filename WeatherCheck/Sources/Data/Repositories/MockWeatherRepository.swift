//
//  MockWeatherRepository.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/2/24.
//

import RxSwift

final class MockWeatherRepository: WeatherRepository {
    func fetchWeatherData() -> Observable<WeatherData> {
        .just(WeatherData(
            cityName: "Seoul",
            currentTemperature: 7,
            weatherStatus: "맑음",
            minTemperature: 0,
            maxTemperature: 10,
            hourlyWeathers: [
                HourlyWeather(time: "지금", weatherStatus: "01d", temperature: 10),
                HourlyWeather(time: "오전 11시", weatherStatus: "01d", temperature: 13),
                HourlyWeather(time: "오후 2시", weatherStatus: "01d", temperature: 15),
                HourlyWeather(time: "오후 5시", weatherStatus: "01d", temperature: 17),
                HourlyWeather(time: "오후 8시", weatherStatus: "01d", temperature: 14),
                HourlyWeather(time: "오후 11시", weatherStatus: "01d", temperature: 11),
            ]
        ))
    }
}
