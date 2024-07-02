//
//  FetchWeatherUseCase.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/2/24.
//

import RxSwift

protocol FetchWeatherUseCase {
    func fetch() -> Observable<WeatherData>
}

final class DefaultFetchWeatherUseCase: FetchWeatherUseCase {
    
    private let weatherRepository: WeatherRepository
    
    init(weatherRepository: WeatherRepository) {
        self.weatherRepository = weatherRepository
    }
    
    func fetch() -> Observable<WeatherData> {
        weatherRepository.fetchWeatherData()
    }
}
