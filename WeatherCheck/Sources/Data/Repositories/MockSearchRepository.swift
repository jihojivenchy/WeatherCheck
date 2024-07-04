//
//  MockSearchRepository.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/3/24.
//

import RxSwift

final class MockSearchRepository: SearchRepository {
    func searchWeather(for cityID: Int) -> Observable<Weather> {
        .just(Weather(
            city: City(id: 1839726, name: "Asan", country: "KR", coordinate: Coordinate(latitude: 36.783611, longitude: 127.004173)),
            currentTemperature: 7,
            weatherStatus: "맑음",
            minTemperature: 0,
            maxTemperature: 10,
            hourlyWeathers: [
                HourlyWeather(time: "지금", iconID: "01d", temperature: 10),
                HourlyWeather(time: "오전 11시", iconID: "01d", temperature: 13),
                HourlyWeather(time: "오후 2시", iconID: "01d", temperature: 15),
                HourlyWeather(time: "오후 5시", iconID: "01d", temperature: 17),
                HourlyWeather(time: "오후 8시", iconID: "01d", temperature: 14),
                HourlyWeather(time: "오후 11시", iconID: "01d", temperature: 11),
            ],
            dailyWeather: [
                DailyWeather(day: "오늘", iconID: "13d", minTemperature: -7, maxTemperature: 7),
                DailyWeather(day: "수", iconID: "13d", minTemperature: -7, maxTemperature: 7),
                DailyWeather(day: "목", iconID: "13d", minTemperature: 7, maxTemperature: 14),
                DailyWeather(day: "금", iconID: "11d", minTemperature: 11, maxTemperature: 16),
                DailyWeather(day: "토", iconID: "11d", minTemperature: 15, maxTemperature: 23)
            ],
            humidity: 56,
            clouds: 50,
            windSpeed: 1.97,
            pressure: 1030
        ))
    }
    
    func searchCityList(for name: String) -> Observable<[City]> {
        .just([])
    }
}
