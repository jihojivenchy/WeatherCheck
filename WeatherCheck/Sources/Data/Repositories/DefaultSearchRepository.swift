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
    private let bundleFileService: BundleFileService
    
    // MARK: - Init
    init(bundleFileService: BundleFileService) {
        self.bundleFileService = bundleFileService
    }
    
    // MARK: - Methods
    func searchWeather() -> Observable<Weather> {
        .just(Weather.onError)
    }
    
    func searchCity(name: String) -> Observable<[City]> {
        return bundleFileService.fetchData(fromResource: "reduced_citylist", ofType: "json")
            .decode(type: [CitySearchResponseDTO].self, decoder: JSONDecoder())
            .map { dtos in dtos.filter { $0.name == name }}
            .map { dtos in
                dtos.map { $0.toEntity() }
            }
    }
}
