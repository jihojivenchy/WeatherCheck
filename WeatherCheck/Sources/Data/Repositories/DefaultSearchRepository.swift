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
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))  // 백그라운드 스레드에서 데이터 처리
            .decode(type: [CitySearchResponseDTO].self, decoder: JSONDecoder())
            .map { dtos in 
                dtos.filter { !$0.name.isEmpty && $0.name.lowercased().contains(name.lowercased()) }
                    .prefix(20)
            }
            .map { dtos in
                dtos.map { $0.toEntity() }
            }
    }
}
