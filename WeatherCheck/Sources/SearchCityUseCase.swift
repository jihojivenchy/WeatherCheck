//
//  SearchCityUseCase.swift
//  WeatherCheck
//
//  Created by 엄지호 on 7/3/24.
//

import RxSwift

protocol SearchCityUseCase {
    func search(name: String) -> Observable<[City]>
}

final class DefaultSearchCityUseCase: SearchCityUseCase {
    
    private let searchRepository: SearchRepository
    
    init(searchRepository: SearchRepository) {
        self.searchRepository = searchRepository
    }
    
    func search(name: String) -> Observable<[City]> {
        searchRepository.searchCity(name: name)
    }
}
