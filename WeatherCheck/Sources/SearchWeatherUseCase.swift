//
//  FetchWeatherUseCase.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/2/24.
//

import RxSwift

// TODO: - 쿼리 구현
protocol SearchWeatherUseCase {
    func search(cityID: Int) -> Observable<Weather>
}

final class DefaultSearchWeatherUseCase: SearchWeatherUseCase {
    
    private let searchRepository: SearchRepository
    
    init(searchRepository: SearchRepository) {
        self.searchRepository = searchRepository
    }
    
    func search(cityID: Int) -> Observable<Weather> {
        searchRepository.searchWeather(cityID: cityID)
    }
}
