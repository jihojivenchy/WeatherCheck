//
//  DefaultSearchRepository.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/3/24.
//

import Foundation
import RxSwift

final class DefaultSearchRepository: SearchRepository {
    // MARK: - Properties
    private let networkService: NetworkService
    
    // MARK: - Init
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: - Methods
    func searchWeather() -> Observable<Weather> {
        .just(Weather.onError)
    }
    
    func searchCity() -> Observable<[City]> {
        .just([])
    }
}
