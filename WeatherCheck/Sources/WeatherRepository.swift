//
//  WeatherRepository.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/2/24.
//

import RxSwift

protocol WeatherRepository {
    func fetchWeatherData() -> Observable<WeatherData>
}
