//
//  MockSearchRepository.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/3/24.
//

import RxSwift

final class MockSearchRepository: SearchRepository {
    func searchWeather(for cityID: Int) -> Observable<Weather> {
        .error(NetworkError.invalidRequest)
    }
    
    func searchCityList(for name: String) -> Observable<[City]> {
        .error(BundleFileError.invalidPath)
    }
}
